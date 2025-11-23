#!/bin/bash
#
# KVM Virtual Machine Optimization Script
# This script optimizes VM performance for better Windows 11 experience
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_prompt() {
    echo -e "${BLUE}[INPUT]${NC} $1"
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "This operation requires root privileges. Please run with sudo."
        exit 1
    fi
}

# Show usage
show_usage() {
    echo "KVM VM Optimization Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --all              Apply all optimizations (requires root)"
    echo "  --cpu-pinning      Configure CPU pinning for VMs (requires root)"
    echo "  --huge-pages       Configure huge pages for better memory performance (requires root)"
    echo "  --io-scheduler     Optimize I/O scheduler (requires root)"
    echo "  --network          Optimize network settings (requires root)"
    echo "  --vm-config        Show recommended VM XML configurations"
    echo "  --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  sudo $0 --all"
    echo "  sudo $0 --cpu-pinning"
    echo "  $0 --vm-config"
    echo ""
}

# Configure CPU pinning
optimize_cpu_pinning() {
    check_root
    
    print_info "Configuring CPU pinning for better performance..."
    
    # Get number of CPU cores
    NUM_CORES=$(nproc)
    print_info "Detected $NUM_CORES CPU cores"
    
    # Recommend CPU pinning strategy
    echo ""
    print_info "CPU Pinning Recommendations:"
    echo ""
    echo "For best performance, pin VM CPUs to specific physical cores."
    echo "This reduces CPU scheduling overhead and improves cache efficiency."
    echo ""
    echo "Example VM XML configuration for 4 vCPUs on a system with $NUM_CORES cores:"
    echo ""
    echo "  <vcpu placement='static'>4</vcpu>"
    echo "  <cputune>"
    echo "    <vcpupin vcpu='0' cpuset='0'/>"
    echo "    <vcpupin vcpu='1' cpuset='1'/>"
    echo "    <vcpupin vcpu='2' cpuset='2'/>"
    echo "    <vcpupin vcpu='3' cpuset='3'/>"
    echo "  </cputune>"
    echo ""
    echo "To apply: virsh edit <vm-name>"
    echo ""
    
    # Configure CPU governor
    print_info "Setting CPU governor to 'performance' mode..."
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo performance > "$cpu" 2>/dev/null || true
    done
    
    print_info "CPU optimization complete!"
}

# Configure huge pages
optimize_huge_pages() {
    check_root
    
    print_info "Configuring huge pages for VMs..."
    
    # Calculate recommended huge pages (reserve 25% of RAM for VMs)
    TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
    # 2MB per huge page, ensuring minimum of 512 pages (1GB)
    HUGE_PAGES=$((TOTAL_MEM * 25 / 100 / 2))
    if [ $HUGE_PAGES -lt 512 ]; then
        HUGE_PAGES=512
    fi
    
    print_info "Total RAM: ${TOTAL_MEM}MB"
    print_info "Recommended huge pages: $HUGE_PAGES (${HUGE_PAGES}MB)"
    
    # Configure huge pages
    echo $HUGE_PAGES > /proc/sys/vm/nr_hugepages
    
    # Make it persistent
    if ! grep -q "vm.nr_hugepages" /etc/sysctl.conf; then
        echo "vm.nr_hugepages = $HUGE_PAGES" >> /etc/sysctl.conf
        print_info "Huge pages configuration added to /etc/sysctl.conf"
    fi
    
    # Configure libvirt to use huge pages
    if ! grep -q "hugetlbfs_mount" /etc/libvirt/qemu.conf; then
        echo 'hugetlbfs_mount = "/dev/hugepages"' >> /etc/libvirt/qemu.conf
        systemctl restart libvirtd
        print_info "Libvirt configured to use huge pages"
    fi
    
    print_info "To use huge pages in a VM, add this to VM XML:"
    echo "  <memoryBacking>"
    echo "    <hugepages/>"
    echo "  </memoryBacking>"
    echo ""
}

# Optimize I/O scheduler
optimize_io() {
    check_root
    
    print_info "Optimizing I/O scheduler..."
    
    # Set I/O scheduler to 'none' or 'mq-deadline' for SSDs
    for disk in /sys/block/sd*; do
        if [ -d "$disk/queue" ]; then
            DISK_NAME=$(basename "$disk")
            
            # Check if it's an SSD or NVMe
            if [ -f "$disk/queue/rotational" ]; then
                IS_ROTATIONAL=$(cat "$disk/queue/rotational")
                
                if [ "$IS_ROTATIONAL" == "0" ]; then
                    # SSD - use 'none' or 'mq-deadline'
                    echo "none" > "$disk/queue/scheduler" 2>/dev/null || \
                    echo "mq-deadline" > "$disk/queue/scheduler" 2>/dev/null || true
                    print_info "Set scheduler for $DISK_NAME (SSD): none/mq-deadline"
                else
                    # HDD - use 'bfq' or 'mq-deadline'
                    echo "bfq" > "$disk/queue/scheduler" 2>/dev/null || \
                    echo "mq-deadline" > "$disk/queue/scheduler" 2>/dev/null || true
                    print_info "Set scheduler for $DISK_NAME (HDD): bfq/mq-deadline"
                fi
            fi
        fi
    done
    
    # Optimize for NVMe drives
    for nvme in /sys/block/nvme*; do
        if [ -d "$nvme/queue" ]; then
            NVME_NAME=$(basename "$nvme")
            echo "none" > "$nvme/queue/scheduler" 2>/dev/null || true
            print_info "Set scheduler for $NVME_NAME (NVMe): none"
        fi
    done
    
    print_info "I/O scheduler optimization complete!"
}

# Optimize network settings
optimize_network() {
    check_root
    
    print_info "Optimizing network settings for VMs..."
    
    # Increase network buffer sizes
    sysctl -w net.core.rmem_max=134217728 > /dev/null 2>&1
    sysctl -w net.core.wmem_max=134217728 > /dev/null 2>&1
    sysctl -w net.ipv4.tcp_rmem="4096 87380 67108864" > /dev/null 2>&1
    sysctl -w net.ipv4.tcp_wmem="4096 65536 67108864" > /dev/null 2>&1
    
    # Make settings persistent (check if not already present)
    if ! grep -q "KVM VM network optimizations" /etc/sysctl.conf; then
        cat >> /etc/sysctl.conf << 'EOF'
# KVM VM network optimizations
net.core.rmem_max = 134217728
net.core.wmem_max = 134217728
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_congestion_control = bbr
EOF
    fi
    
    print_info "Network optimization complete!"
    print_info "For VM network performance, ensure VirtIO network drivers are used."
}

# Show recommended VM configurations
show_vm_config() {
    print_info "Recommended VM XML Configurations for Optimal Performance"
    echo ""
    
    cat << 'EOF'
1. CPU Configuration (with topology and pinning):
   <vcpu placement='static'>4</vcpu>
   <cpu mode='host-passthrough' check='none' migratable='on'>
     <topology sockets='1' dies='1' cores='4' threads='1'/>
     <feature policy='require' name='topoext'/>
   </cpu>
   <cputune>
     <vcpupin vcpu='0' cpuset='0'/>
     <vcpupin vcpu='1' cpuset='1'/>
     <vcpupin vcpu='2' cpuset='2'/>
     <vcpupin vcpu='3' cpuset='3'/>
   </cputune>

2. Memory Configuration (with huge pages):
   <memory unit='GiB'>8</memory>
   <memoryBacking>
     <hugepages/>
   </memoryBacking>

3. Disk Configuration (VirtIO SCSI for best performance):
   <disk type='file' device='disk'>
     <driver name='qemu' type='qcow2' cache='writeback' io='threads' discard='unmap'/>
     <source file='/var/lib/libvirt/images/windows11.qcow2'/>
     <target dev='sda' bus='scsi'/>
   </disk>
   <controller type='scsi' model='virtio-scsi'/>

4. Network Configuration (VirtIO with multi-queue):
   <interface type='network'>
     <source network='default'/>
     <model type='virtio'/>
     <driver name='vhost' queues='4'/>
   </interface>

5. Graphics Configuration (for better performance):
   <graphics type='spice' port='-1' autoport='yes' listen='127.0.0.1'>
     <listen type='address' address='127.0.0.1'/>
     <image compression='off'/>
     <gl enable='yes'/>
   </graphics>
   <video>
     <model type='virtio' heads='1' primary='yes'>
       <acceleration accel3d='yes'/>
     </model>
   </video>

6. Clock Configuration (for Windows):
   <clock offset='localtime'>
     <timer name='rtc' tickpolicy='catchup'/>
     <timer name='pit' tickpolicy='delay'/>
     <timer name='hpet' present='no'/>
     <timer name='hypervclock' present='yes'/>
   </clock>

7. Hyper-V Enlightenments (for Windows VMs):
   <features>
     <hyperv mode='custom'>
       <relaxed state='on'/>
       <vapic state='on'/>
       <spinlocks state='on' retries='8191'/>
       <vpindex state='on'/>
       <synic state='on'/>
       <stimer state='on'/>
       <reset state='on'/>
       <vendor_id state='on' value='1234567890ab'/>
       <frequencies state='on'/>
     </hyperv>
   </features>

To apply these configurations:
1. Edit your VM: virsh edit <vm-name>
2. Add or modify the relevant sections
3. Save and restart the VM
EOF
    
    echo ""
    print_info "For more details, see: https://www.linux-kvm.org/page/Tuning_KVM"
}

# Apply all optimizations
apply_all() {
    check_root
    
    print_info "Applying all optimizations..."
    echo ""
    
    optimize_cpu_pinning
    echo ""
    optimize_huge_pages
    echo ""
    optimize_io
    echo ""
    optimize_network
    echo ""
    
    print_info "All optimizations applied successfully!"
    print_info "You may need to reboot for all changes to take effect."
}

# Main script logic
if [ $# -eq 0 ]; then
    show_usage
    exit 0
fi

case "$1" in
    --all)
        apply_all
        ;;
    --cpu-pinning)
        optimize_cpu_pinning
        ;;
    --huge-pages)
        optimize_huge_pages
        ;;
    --io-scheduler)
        optimize_io
        ;;
    --network)
        optimize_network
        ;;
    --vm-config)
        show_vm_config
        ;;
    --help)
        show_usage
        ;;
    *)
        print_error "Unknown option: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac

exit 0
