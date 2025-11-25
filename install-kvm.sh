#!/bin/bash
#
# KVM Installation Script for Fedora Workstation 43
# This script installs and configures KVM/QEMU with libvirt on Fedora 43
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run this script with sudo or as root"
    exit 1
fi

# Check if running on Fedora
if [ ! -f /etc/fedora-release ]; then
    print_error "This script is designed for Fedora. Your system doesn't appear to be Fedora."
    exit 1
fi

print_info "Starting KVM installation for Fedora Workstation 43..."

# Step 1: Check CPU virtualization support
print_info "Checking CPU virtualization support..."
if grep -E 'vmx|svm' /proc/cpuinfo > /dev/null; then
    print_info "CPU virtualization support detected ✓"
else
    print_error "CPU virtualization support not detected!"
    print_warning "Please enable VT-x (Intel) or AMD-V (AMD) in your BIOS/UEFI settings."
    exit 1
fi

# Step 2: Update system
print_info "Updating system packages..."
dnf update -y

# Step 3: Install KVM and virtualization packages
print_info "Installing KVM, QEMU, and libvirt packages..."
dnf install -y \
    @virtualization \
    qemu-kvm \
    libvirt \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    virt-install \
    virt-manager \
    virt-viewer \
    virt-top \
    libguestfs-tools \
    guestfs-tools

# Step 4: Install additional useful packages
print_info "Installing additional virtualization tools..."
dnf install -y \
    edk2-ovmf \
    swtpm \
    swtpm-tools \
    bridge-utils \
    dnsmasq \
    iptables

# Step 5: Enable and start libvirtd service
print_info "Enabling and starting libvirtd service..."
systemctl enable libvirtd
systemctl start libvirtd

# Step 6: Configure default network
print_info "Configuring default virtual network..."
if ! virsh net-list --all | grep -q "default"; then
    print_info "Creating default network..."
    virsh net-define /usr/share/libvirt/networks/default.xml
fi

virsh net-autostart default
virsh net-start default 2>/dev/null || true

# Step 7: Add current user to libvirt group
if [ -n "$SUDO_USER" ]; then
    print_info "Adding user $SUDO_USER to libvirt and kvm groups..."
    usermod -aG libvirt "$SUDO_USER"
    usermod -aG kvm "$SUDO_USER"
    print_warning "User $SUDO_USER added to libvirt and kvm groups."
    print_warning "Please log out and log back in for group changes to take effect."
else
    print_warning "Running as root. Please manually add your user to libvirt and kvm groups:"
    print_warning "sudo usermod -aG libvirt,kvm YOUR_USERNAME"
fi

# Step 8: Enable nested virtualization (if applicable)
print_info "Configuring nested virtualization..."
if lscpu | grep -q "GenuineIntel"; then
    # Intel CPU
    if [ ! -f /etc/modprobe.d/kvm-intel.conf ]; then
        echo "options kvm-intel nested=1" > /etc/modprobe.d/kvm-intel.conf
        print_info "Nested virtualization enabled for Intel CPU"
    fi
elif lscpu | grep -q "AuthenticAMD"; then
    # AMD CPU
    if [ ! -f /etc/modprobe.d/kvm-amd.conf ]; then
        echo "options kvm-amd nested=1" > /etc/modprobe.d/kvm-amd.conf
        print_info "Nested virtualization enabled for AMD CPU"
    fi
fi

# Step 9: Configure libvirt for better performance
print_info "Configuring libvirt settings..."

# Allow users in libvirt group to manage VMs without password
if ! grep -q "unix_sock_group" /etc/libvirt/libvirtd.conf; then
    sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
    sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
fi

# Enable TPM emulation support
if ! grep -q "swtpm_user" /etc/libvirt/qemu.conf; then
    echo 'swtpm_user = "tss"' >> /etc/libvirt/qemu.conf
    echo 'swtpm_group = "tss"' >> /etc/libvirt/qemu.conf
fi

# Step 10: Restart libvirtd to apply changes
print_info "Restarting libvirtd service..."
systemctl restart libvirtd

# Step 11: Configure firewall
print_info "Configuring firewall for KVM..."
if command -v firewall-cmd &> /dev/null; then
    firewall-cmd --permanent --add-service=libvirt
    firewall-cmd --reload
    print_info "Firewall configured for libvirt"
fi

# Step 12: Create directory for VM images (if it doesn't exist)
print_info "Setting up VM storage directory..."
VM_DIR="/var/lib/libvirt/images"
if [ ! -d "$VM_DIR" ]; then
    mkdir -p "$VM_DIR"
    chmod 711 "$VM_DIR"
fi

# Step 13: Verify installation
print_info "Verifying KVM installation..."
if systemctl is-active --quiet libvirtd; then
    print_info "libvirtd service is running ✓"
else
    print_error "libvirtd service is not running!"
    exit 1
fi

if lsmod | grep -q kvm; then
    print_info "KVM kernel module is loaded ✓"
else
    print_error "KVM kernel module is not loaded!"
    exit 1
fi

# Step 14: Display system info
print_info "Installation complete! Here's your virtualization setup:"
echo ""
echo "KVM Module:"
lsmod | grep kvm || echo "  Not loaded"
echo ""
echo "Libvirt Version:"
libvirtd --version
echo ""
echo "QEMU Version:"
qemu-system-x86_64 --version | head -n 1
echo ""
echo "Virtual Networks:"
virsh net-list --all
echo ""

# Final instructions
print_info "=== Installation Complete ==="
echo ""
print_info "Next steps:"
echo "  1. Log out and log back in for group membership to take effect"
echo "  2. Verify installation with: virsh list --all"
echo "  3. Launch virt-manager GUI: virt-manager"
echo "  4. Create a Windows 11 VM with: ./create-windows11-vm.sh"
echo ""
print_warning "If this is your first time using KVM, please reboot your system to ensure all changes take effect."
echo ""

exit 0
