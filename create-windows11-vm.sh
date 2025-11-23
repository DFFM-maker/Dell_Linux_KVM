#!/bin/bash
#
# Windows 11 VM Creation Script for Fedora Workstation 43
# This script creates an optimized Windows 11 virtual machine with KVM
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

# Default VM settings
VM_NAME="windows11"
VM_VCPUS=4
VM_RAM=8192  # in MB (8GB)
VM_DISK_SIZE=60  # in GB
VM_DIR="/var/lib/libvirt/images"
OVMF_CODE="/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd"
OVMF_VARS="/usr/share/edk2/ovmf/OVMF_VARS.fd"

print_info "Windows 11 VM Creation Script for KVM"
echo ""

# Check if libvirtd is running
if ! systemctl is-active --quiet libvirtd; then
    print_error "libvirtd is not running. Please run install-kvm.sh first."
    exit 1
fi

# Check for virt-install
if ! command -v virt-install &> /dev/null; then
    print_error "virt-install not found. Please run install-kvm.sh first."
    exit 1
fi

# Get VM configuration from user
print_info "VM Configuration"
echo ""

read -p "Enter VM name [default: windows11]: " input_name
VM_NAME=${input_name:-$VM_NAME}

# Check if VM already exists
if virsh list --all | grep -q "$VM_NAME"; then
    print_error "VM '$VM_NAME' already exists!"
    read -p "Do you want to delete it and create a new one? (yes/no): " confirm
    if [ "$confirm" == "yes" ]; then
        print_info "Removing existing VM..."
        virsh destroy "$VM_NAME" 2>/dev/null || true
        virsh undefine "$VM_NAME" --nvram 2>/dev/null || true
        rm -f "${VM_DIR}/${VM_NAME}.qcow2"
    else
        print_error "Aborting."
        exit 1
    fi
fi

read -p "Enter number of CPU cores [default: 4]: " input_cpu
VM_VCPUS=${input_cpu:-$VM_VCPUS}

read -p "Enter RAM size in GB [default: 8]: " input_ram_gb
input_ram_gb=${input_ram_gb:-8}
VM_RAM=$((input_ram_gb * 1024))

read -p "Enter disk size in GB [default: 60]: " input_disk
VM_DISK_SIZE=${input_disk:-$VM_DISK_SIZE}

# Ask for Windows 11 ISO path
echo ""
print_prompt "Please provide the path to Windows 11 ISO file:"
print_info "You can download Windows 11 from: https://www.microsoft.com/software-download/windows11"
read -p "ISO path: " WIN11_ISO

if [ ! -f "$WIN11_ISO" ]; then
    print_error "ISO file not found: $WIN11_ISO"
    exit 1
fi

# Download VirtIO drivers ISO if not present
VIRTIO_ISO_URL="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"
VIRTIO_ISO="${VM_DIR}/virtio-win.iso"

if [ ! -f "$VIRTIO_ISO" ]; then
    print_info "Downloading VirtIO drivers ISO..."
    wget -O "$VIRTIO_ISO" "$VIRTIO_ISO_URL" || {
        print_warning "Failed to download VirtIO drivers. The VM will be created without VirtIO drivers."
        print_warning "You can manually download from: $VIRTIO_ISO_URL"
        VIRTIO_ISO=""
    }
else
    print_info "VirtIO drivers ISO already exists at $VIRTIO_ISO"
fi

# Check for OVMF firmware files
if [ ! -f "$OVMF_CODE" ]; then
    # Try alternative path
    OVMF_CODE="/usr/share/OVMF/OVMF_CODE.secboot.fd"
    if [ ! -f "$OVMF_CODE" ]; then
        print_error "OVMF firmware not found. Please install edk2-ovmf package."
        exit 1
    fi
fi

if [ ! -f "$OVMF_VARS" ]; then
    # Try alternative path
    OVMF_VARS="/usr/share/OVMF/OVMF_VARS.fd"
    if [ ! -f "$OVMF_VARS" ]; then
        print_error "OVMF variables file not found."
        exit 1
    fi
fi

# Create VM disk image
print_info "Creating VM disk image (${VM_DISK_SIZE}GB)..."
qemu-img create -f qcow2 "${VM_DIR}/${VM_NAME}.qcow2" "${VM_DISK_SIZE}G"

# Build virt-install command
print_info "Creating Windows 11 virtual machine..."
echo ""
print_info "VM Configuration Summary:"
echo "  Name: $VM_NAME"
echo "  CPUs: $VM_VCPUS"
echo "  RAM: ${input_ram_gb}GB"
echo "  Disk: ${VM_DISK_SIZE}GB"
echo "  ISO: $WIN11_ISO"
echo ""

VIRT_INSTALL_CMD="virt-install \
    --name $VM_NAME \
    --memory $VM_RAM \
    --vcpus $VM_VCPUS \
    --disk path=${VM_DIR}/${VM_NAME}.qcow2,format=qcow2,bus=virtio,cache=writeback \
    --cdrom $WIN11_ISO \
    --os-variant win11 \
    --network network=default,model=virtio \
    --graphics spice,listen=127.0.0.1 \
    --video qxl \
    --channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
    --boot uefi,loader=$OVMF_CODE,loader_readonly=yes,loader_type=pflash,nvram_template=$OVMF_VARS \
    --tpm backend.type=emulator,backend.version=2.0,model=tpm-crb \
    --features smm=on \
    --console pty,target_type=serial"

# Add VirtIO ISO if available
if [ -n "$VIRTIO_ISO" ] && [ -f "$VIRTIO_ISO" ]; then
    VIRT_INSTALL_CMD="$VIRT_INSTALL_CMD --disk $VIRTIO_ISO,device=cdrom,bus=sata"
fi

# Add no-autoconsole to avoid immediately connecting
VIRT_INSTALL_CMD="$VIRT_INSTALL_CMD --noautoconsole"

# Execute the command
print_info "Starting VM creation..."
eval $VIRT_INSTALL_CMD

# Wait a moment for VM to start
sleep 3

# Check if VM is running
if virsh list | grep -q "$VM_NAME"; then
    print_info "VM '$VM_NAME' created successfully! ✓"
    echo ""
    print_info "Important Windows 11 Installation Notes:"
    echo ""
    echo "1. During Windows 11 installation, you'll need to load VirtIO drivers:"
    echo "   - When you don't see any disks, click 'Load driver'"
    echo "   - Browse to the VirtIO CD (usually E: drive)"
    echo "   - Navigate to vioscsi/w11/amd64 and install the driver"
    echo "   - Navigate to NetKVM/w11/amd64 and install the network driver"
    echo ""
    echo "2. To bypass Windows 11 system requirements during installation:"
    echo "   - Press Shift+F10 to open command prompt"
    echo "   - Type: regedit"
    echo "   - Navigate to: HKEY_LOCAL_MACHINE\\SYSTEM\\Setup"
    echo "   - Create new key: LabConfig"
    echo "   - Inside LabConfig, create DWORD values:"
    echo "     - BypassTPMCheck = 1"
    echo "     - BypassSecureBootCheck = 1"
    echo "     - BypassRAMCheck = 1"
    echo "   - Close registry editor and continue installation"
    echo ""
    echo "   Alternatively, press Shift+F10 and run these commands:"
    echo "     reg add HKLM\\SYSTEM\\Setup\\LabConfig /v BypassTPMCheck /t REG_DWORD /d 1 /f"
    echo "     reg add HKLM\\SYSTEM\\Setup\\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 1 /f"
    echo "     reg add HKLM\\SYSTEM\\Setup\\LabConfig /v BypassRAMCheck /t REG_DWORD /d 1 /f"
    echo ""
    echo "3. Connect to the VM using virt-manager or:"
    echo "   virt-viewer $VM_NAME"
    echo ""
    print_info "Useful commands:"
    echo "  View VM:     virt-viewer $VM_NAME"
    echo "  Start VM:    virsh start $VM_NAME"
    echo "  Stop VM:     virsh shutdown $VM_NAME"
    echo "  Delete VM:   virsh undefine $VM_NAME --nvram && rm ${VM_DIR}/${VM_NAME}.qcow2"
    echo ""
    
    # Try to open virt-manager if available
    if command -v virt-manager &> /dev/null; then
        print_info "Opening virt-manager..."
        virt-manager --connect qemu:///system --show-domain-console "$VM_NAME" &
    fi
else
    print_error "Failed to create VM. Please check the error messages above."
    exit 1
fi

exit 0
