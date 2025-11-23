# Quick Start Guide

This is a quick reference for getting up and running with KVM on Fedora Workstation 43 with Windows 11-like interface.

## Prerequisites Check

Before you begin, verify your system meets the requirements:

```bash
# Check CPU virtualization support
grep -E 'vmx|svm' /proc/cpuinfo

# Check Fedora version
cat /etc/fedora-release

# Ensure you have at least 8GB RAM
free -h
```

## Step-by-Step Installation

### 1. Clone the Repository

```bash
git clone https://github.com/DFFM-maker/Dell_Linux_KVM.git
cd Dell_Linux_KVM
```

### 2. Install KVM

Run the installation script with sudo:

```bash
sudo ./install-kvm.sh
```

This will:
- Install KVM, QEMU, libvirt, and related packages
- Enable and start libvirtd service
- Configure default virtual network
- Add your user to libvirt and kvm groups
- Enable nested virtualization
- Configure TPM emulation support

**Important:** After installation completes, log out and log back in for group membership changes to take effect.

### 3. Verify Installation

```bash
# Check if libvirtd is running
sudo systemctl status libvirtd

# Check if KVM module is loaded
lsmod | grep kvm

# List virtual networks
virsh net-list --all

# Try launching virt-manager
virt-manager
```

### 4. Create Windows 11 VM

You'll need a Windows 11 ISO file. Download it from [Microsoft](https://www.microsoft.com/software-download/windows11).

Then run:

```bash
./create-windows11-vm.sh
```

The script will:
- Prompt for VM configuration (name, CPU, RAM, disk size)
- Ask for Windows 11 ISO path
- Download VirtIO drivers automatically
- Create the VM with optimal settings
- Configure TPM 2.0 and UEFI
- Open virt-manager for installation

**During Windows 11 Installation:**

When you don't see any disks in the installer:
1. Click "Load driver"
2. Browse to the VirtIO CD drive
3. Navigate to `vioscsi/w11/amd64`
4. Install the SCSI driver

To bypass Windows 11 system checks:
1. Press `Shift+F10` to open command prompt
2. Run these commands:
```cmd
reg add HKLM\SYSTEM\Setup\LabConfig /v BypassTPMCheck /t REG_DWORD /d 1 /f
reg add HKLM\SYSTEM\Setup\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 1 /f
reg add HKLM\SYSTEM\Setup\LabConfig /v BypassRAMCheck /t REG_DWORD /d 1 /f
```

### 5. Apply Windows 11-like GNOME Theme (Optional)

After Windows 11 is installed, you can make your Fedora desktop look like Windows 11:

```bash
./apply-windows11-theme.sh
```

This will:
- Install GNOME Tweaks and Extensions
- Download and install WhiteSur GTK theme
- Configure Windows 11-like keyboard shortcuts
- Set up taskbar at the bottom
- Apply dark theme

**Manual Steps Required:**
1. Open Extensions app
2. Install recommended extensions from extensions.gnome.org:
   - Dash to Panel
   - Arc Menu
   - Blur my Shell
   - Just Perfection
   - Window Rounded Corners
3. Configure extensions to your preference

### 6. Optimize VM Performance (Optional)

For better performance:

```bash
# View recommended configurations
sudo ./optimize-vm.sh --vm-config

# Apply all optimizations
sudo ./optimize-vm.sh --all

# Or apply specific optimizations
sudo ./optimize-vm.sh --cpu-pinning
sudo ./optimize-vm.sh --huge-pages
sudo ./optimize-vm.sh --io-scheduler
sudo ./optimize-vm.sh --network
```

## Managing Your VM

### Start/Stop VM

```bash
# Start VM
virsh start windows11

# Stop VM gracefully
virsh shutdown windows11

# Force stop VM
virsh destroy windows11

# View VM console
virt-viewer windows11

# Launch virt-manager GUI
virt-manager
```

### Snapshots

```bash
# Create snapshot
virsh snapshot-create-as windows11 snapshot1 "Description"

# List snapshots
virsh snapshot-list windows11

# Restore snapshot
virsh snapshot-revert windows11 snapshot1

# Delete snapshot
virsh snapshot-delete windows11 snapshot1
```

### VM Information

```bash
# List all VMs
virsh list --all

# VM details
virsh dominfo windows11

# VM CPU info
virsh vcpuinfo windows11

# VM memory stats
virsh dommemstat windows11

# Disk performance
virsh domblkstat windows11 vda

# Network performance
virsh domifstat windows11 vnet0
```

## Common Issues & Solutions

### Issue: VM won't start

**Solution:**
```bash
# Check if virtualization is enabled
grep -E 'vmx|svm' /proc/cpuinfo

# Check libvirtd status
sudo systemctl status libvirtd

# View VM logs
sudo tail -f /var/log/libvirt/qemu/windows11.log
```

### Issue: Poor VM performance

**Solution:**
1. Ensure VirtIO drivers are installed in Windows
2. Allocate more resources to the VM
3. Run optimization script: `sudo ./optimize-vm.sh --all`
4. Use virsh to check resource usage

### Issue: Network not working in VM

**Solution:**
```bash
# Check if default network is active
virsh net-list --all

# Start default network
virsh net-start default

# Check Windows Firewall settings in the VM
```

### Issue: Can't access VM from host

**Solution:**
1. Check VM IP: In VM, run `ipconfig`
2. Try pinging from host: `ping <vm-ip>`
3. Check Windows Firewall in VM
4. Verify VM is on default network

## Next Steps

- Read the [Advanced Configuration Guide](docs/ADVANCED.md) for more customization
- Set up [GPU Passthrough](docs/GPU-PASSTHROUGH.md) for gaming
- Configure [Advanced Networking](docs/NETWORKING.md)
- Set up [Automated Backups](docs/BACKUP.md)

## Getting Help

- Check the [README.md](README.md) for comprehensive documentation
- Review documentation in the `docs/` directory
- Check existing issues on GitHub
- Open a new issue if you encounter problems

## Tips & Best Practices

1. **Always create snapshots before major changes**
2. **Keep backups of important VMs**
3. **Allocate resources wisely** - Don't give VM all your CPU/RAM
4. **Use VirtIO drivers** for best performance
5. **Enable huge pages** for VMs with high memory usage
6. **Pin CPUs** for consistent performance
7. **Use SSD/NVMe** for VM disk images
8. **Keep host system updated**: `sudo dnf update`

## Resource Requirements

### Minimal Setup
- CPU: 4 cores (2 for host, 2 for VM)
- RAM: 8GB (4GB for host, 4GB for VM)
- Disk: 80GB (20GB for host, 60GB for VM)

### Recommended Setup
- CPU: 8+ cores (4 for host, 4+ for VM)
- RAM: 16GB+ (8GB for host, 8GB+ for VM)
- Disk: 120GB+ on SSD/NVMe
- GPU: Integrated for host + discrete for VM (if doing GPU passthrough)

## Performance Expectations

With proper configuration:
- **Boot time**: 10-30 seconds
- **Application performance**: 85-95% of native
- **Graphics (with VirtIO-GPU)**: Good for desktop use
- **Graphics (with GPU passthrough)**: 90-95% of native
- **Network throughput**: Near-native with VirtIO
- **Disk I/O**: Good with VirtIO-SCSI on SSD

Enjoy your Windows 11 VM on Fedora 43! 🚀
