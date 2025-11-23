# Dell Linux KVM - Windows 11-like Setup for Fedora Workstation 43

A comprehensive guide and automation scripts for setting up KVM (Kernel-based Virtual Machine) on Fedora Workstation 43 GNOME with a Windows 11-like interface experience.

## Overview

This repository provides scripts and configurations to:
- Install and configure KVM/QEMU on Fedora Workstation 43
- Create optimized Windows 11 virtual machines
- Customize GNOME to provide a Windows 11-like user experience
- Optimize performance for Dell hardware

## Prerequisites

- Dell computer with:
  - Intel VT-x or AMD-V capable CPU
  - At least 8GB RAM (16GB+ recommended)
  - 50GB+ free disk space
- Fedora Workstation 43 installed
- GNOME desktop environment
- Sudo/root access

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/DFFM-maker/Dell_Linux_KVM.git
cd Dell_Linux_KVM
```

2. Make scripts executable:
```bash
chmod +x *.sh
```

3. Install KVM and dependencies:
```bash
sudo ./install-kvm.sh
```

4. Create a Windows 11 VM:
```bash
./create-windows11-vm.sh
```

5. (Optional) Apply Windows 11-like GNOME theme:
```bash
./apply-windows11-theme.sh
```

## Scripts

### install-kvm.sh
Installs and configures KVM, QEMU, libvirt, and related tools on Fedora 43.
- Enables virtualization
- Configures user permissions
- Installs virt-manager GUI

### create-windows11-vm.sh
Creates an optimized Windows 11 virtual machine with:
- TPM 2.0 emulation
- UEFI firmware
- VirtIO drivers for better performance
- Recommended resource allocation

### apply-windows11-theme.sh
Customizes GNOME to look and feel like Windows 11:
- Taskbar-like panel at bottom
- Windows 11-style theme and icons
- Start menu alternative
- Rounded corners and blur effects

### optimize-vm.sh
Performance optimization script for KVM VMs:
- CPU pinning
- Huge pages configuration
- I/O scheduler tuning
- Network optimization

## Detailed Setup Guide

### 1. Verify Hardware Virtualization Support

Check if your CPU supports virtualization:
```bash
grep -E 'vmx|svm' /proc/cpuinfo
```

If no output appears, enable VT-x/AMD-V in your Dell BIOS/UEFI settings.

### 2. Install KVM Stack

Run the installation script:
```bash
sudo ./install-kvm.sh
```

After installation, log out and log back in for group changes to take effect.

### 3. Verify Installation

Check KVM is working:
```bash
sudo systemctl status libvirtd
virsh list --all
```

### 4. Create Windows 11 VM

The script will guide you through:
- Downloading Windows 11 ISO (you'll need to provide the path)
- Downloading VirtIO drivers
- Creating and configuring the VM

```bash
./create-windows11-vm.sh
```

### 5. Customize GNOME (Optional)

For a Windows 11-like experience:
```bash
./apply-windows11-theme.sh
```

This will:
- Move panel to bottom
- Install Windows 11-style GTK theme
- Configure application menu
- Add blur and rounded window effects

## VM Configuration

### Default Windows 11 VM Specifications

- **CPU**: 4 cores (adjust based on your system)
- **RAM**: 8GB (4GB minimum)
- **Disk**: 60GB dynamic
- **Graphics**: QXL/Virtio-GPU with 3D acceleration
- **Network**: NAT with virtio-net
- **TPM**: 2.0 emulated
- **Firmware**: UEFI with Secure Boot

### Modifying VM Resources

Edit VM settings in virt-manager or use virsh:
```bash
virsh edit windows11
```

## Performance Tuning

### CPU Optimization

For better performance, pin VM CPUs to physical cores:
```bash
./optimize-vm.sh --cpu-pinning
```

### GPU Passthrough (Advanced)

For near-native graphics performance, see [GPU-PASSTHROUGH.md](docs/GPU-PASSTHROUGH.md)

### Storage Performance

- Use VirtIO-SCSI for best disk performance
- Consider using raw disk images instead of qcow2 for production VMs
- Place VM images on SSD/NVMe drives

## Troubleshooting

### VM Won't Start
- Check if virtualization is enabled in BIOS
- Verify libvirtd is running: `sudo systemctl status libvirtd`
- Check VM logs: `virsh log windows11`

### Poor Performance
- Ensure VirtIO drivers are installed in Windows 11
- Check if KVM acceleration is enabled: `lsmod | grep kvm`
- Allocate more resources to the VM
- Run the optimization script: `./optimize-vm.sh`

### Windows 11 TPM Requirements
- The script automatically configures TPM 2.0 emulation
- If issues persist, check `/etc/libvirt/qemu.conf` for swtpm configuration

### Network Issues
- Verify the default network is active: `virsh net-list --all`
- Restart the network: `virsh net-start default`
- Check firewall settings

## GNOME Customization

The Windows 11-like theme includes:

### Panel Customization
- Bottom panel with taskbar functionality
- System tray in bottom-right
- Application menu in bottom-left

### Extensions Used
- Dash to Panel
- Arc Menu
- Blur my Shell
- Just Perfection

### Keyboard Shortcuts
Common Windows shortcuts work with the customization:
- `Super` - Open application menu
- `Super + D` - Show desktop
- `Super + L` - Lock screen
- `Alt + F4` - Close window

## Dell-Specific Optimizations

### Power Management
The scripts include Dell-specific power optimizations:
- Proper ACPI handling
- Power profile tuning
- Battery optimization (for laptops)

### Hardware Support
Tested on:
- Dell XPS series
- Dell Precision workstations
- Dell Latitude laptops
- Dell OptiPlex desktops

## Additional Resources

### Documentation
- [Advanced Configuration](docs/ADVANCED.md)
- [GPU Passthrough Guide](docs/GPU-PASSTHROUGH.md)
- [Networking Setup](docs/NETWORKING.md)
- [Backup and Snapshots](docs/BACKUP.md)

### Useful Commands

```bash
# List all VMs
virsh list --all

# Start a VM
virsh start windows11

# Stop a VM
virsh shutdown windows11

# Force stop a VM
virsh destroy windows11

# Delete a VM
virsh undefine windows11

# Create VM snapshot
virsh snapshot-create-as windows11 snapshot1

# Restore snapshot
virsh snapshot-revert windows11 snapshot1

# List snapshots
virsh snapshot-list windows11
```

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

MIT License - See LICENSE file for details

## Acknowledgments

- Fedora Project for the excellent Linux distribution
- QEMU/KVM developers
- GNOME team
- VirtIO drivers team

## Support

For issues specific to this setup:
- Open an issue on GitHub
- Check existing issues for solutions

For general KVM/QEMU questions:
- [Fedora Virtualization Guide](https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/)
- [KVM Documentation](https://www.linux-kvm.org/)
- [QEMU Documentation](https://www.qemu.org/documentation/)

## Version History

### 1.0.0 (Current)
- Initial release
- Fedora Workstation 43 support
- Windows 11 VM creation
- GNOME Windows 11-like theme
- Basic optimization scripts

---

**Note**: This is an unofficial project and is not affiliated with Microsoft, Dell, or the Fedora Project.