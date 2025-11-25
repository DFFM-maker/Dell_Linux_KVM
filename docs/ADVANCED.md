# Advanced KVM Configuration

This guide covers advanced KVM configurations and optimizations for power users.

## Custom Network Configurations

### Bridged Network

Bridged networking gives your VM a direct connection to your physical network.

1. Create a bridge interface:

```bash
sudo nmcli connection add type bridge ifname br0 stp no
sudo nmcli connection add type bridge-slave ifname enp0s3 master br0
```

2. Define bridge network in libvirt:

```xml
<network>
  <name>br0</name>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
```

3. Use in VM:

```xml
<interface type='bridge'>
  <source bridge='br0'/>
  <model type='virtio'/>
</interface>
```

### Isolated Network

Create an isolated network for VM-to-VM communication:

```xml
<network>
  <name>isolated</name>
  <bridge name='virbr1' stp='on' delay='0'/>
  <ip address='192.168.100.1' netmask='255.255.255.0'/>
</network>
```

### MacVTap Network

MacVTap provides near-native network performance:

```xml
<interface type='direct'>
  <source dev='enp0s3' mode='bridge'/>
  <model type='virtio'/>
</interface>
```

## Storage Configurations

### Raw vs QCOW2

**QCOW2 (Default)**
- Pros: Snapshots, thin provisioning, compression
- Cons: Slightly slower performance

**Raw**
- Pros: Better performance, simpler
- Cons: No snapshots, no thin provisioning

Create raw image:
```bash
qemu-img create -f raw /var/lib/libvirt/images/vm.img 60G
```

### LVM Backend

Use LVM for better performance and management:

```bash
# Create LVM volume
sudo lvcreate -L 60G -n windows11 vg0

# Use in VM
<disk type='block' device='disk'>
  <source dev='/dev/vg0/windows11'/>
  <target dev='vda' bus='virtio'/>
</disk>
```

### NVMe Passthrough

Pass through an entire NVMe drive:

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source>
    <address domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
  </source>
</hostdev>
```

## CPU Pinning and NUMA

### CPU Topology

Match VM CPU topology to physical CPU:

```xml
<cpu mode='host-passthrough'>
  <topology sockets='1' dies='1' cores='4' threads='2'/>
</cpu>
```

### NUMA Pinning

For multi-socket systems:

```xml
<numatune>
  <memory mode='strict' nodeset='0'/>
  <memnode cellid='0' mode='strict' nodeset='0'/>
</numatune>

<cpu>
  <numa>
    <cell id='0' cpus='0-3' memory='8388608' unit='KiB'/>
  </numa>
</cpu>
```

### CPU Pinning Script

Create a script for automatic CPU pinning:

```bash
#!/bin/bash
VM_NAME="windows11"
VCPUS=4

for ((i=0; i<$VCPUS; i++)); do
    virsh vcpupin $VM_NAME $i $i
done
```

## Advanced Disk I/O

### Multi-queue VirtIO SCSI

Enable multiple I/O queues:

```xml
<controller type='scsi' model='virtio-scsi'>
  <driver queues='4' iothread='1'/>
</controller>

<disk type='file' device='disk'>
  <driver name='qemu' type='qcow2' cache='writeback' io='threads'/>
  <source file='/var/lib/libvirt/images/windows11.qcow2'/>
  <target dev='sda' bus='scsi'/>
</disk>
```

### Cache Modes

Different cache modes for different use cases:

- `none`: No caching (safest, slower)
- `writethrough`: Host cache read-only (safe)
- `writeback`: Host cache read/write (fastest, less safe)
- `directsync`: Direct I/O, no cache (safest, slower)
- `unsafe`: No flush (fast, data loss risk)

For Windows VMs with proper shutdown, `writeback` is recommended.

### I/O Throttling

Limit disk I/O to prevent one VM from hogging resources:

```xml
<disk type='file' device='disk'>
  <driver name='qemu' type='qcow2'/>
  <source file='/var/lib/libvirt/images/vm.qcow2'/>
  <target dev='vda' bus='virtio'/>
  <iotune>
    <read_bytes_sec>104857600</read_bytes_sec>  <!-- 100 MB/s -->
    <write_bytes_sec>104857600</write_bytes_sec>
    <read_iops_sec>2000</read_iops_sec>
    <write_iops_sec>2000</write_iops_sec>
  </iotune>
</disk>
```

## Memory Optimizations

### Huge Pages Configuration

Reserve huge pages for VMs:

```bash
# Calculate pages needed (VM RAM / 2MB)
# For 8GB VM: 4096 pages
sudo sysctl -w vm.nr_hugepages=4096

# Make persistent
echo "vm.nr_hugepages=4096" | sudo tee -a /etc/sysctl.conf
```

Use in VM:
```xml
<memoryBacking>
  <hugepages/>
  <locked/>
</memoryBacking>
```

### Memory Ballooning

Allow dynamic memory adjustment:

```xml
<memballoon model='virtio'>
  <stats period='5'/>
</memballoon>
```

Adjust VM memory dynamically:
```bash
virsh setmem windows11 6G --live
```

### KSM (Kernel Samepage Merging)

Enable KSM to deduplicate memory pages:

```bash
sudo systemctl enable ksm
sudo systemctl start ksm

echo 1 | sudo tee /sys/kernel/mm/ksm/run
```

## Graphics and Video

### SPICE with GPU Acceleration

Enable 3D acceleration:

```xml
<graphics type='spice' autoport='yes' listen='127.0.0.1'>
  <listen type='address' address='127.0.0.1'/>
  <gl enable='yes' rendernode='/dev/dri/renderD128'/>
</graphics>

<video>
  <model type='virtio' heads='1' primary='yes'>
    <acceleration accel3d='yes'/>
  </model>
</video>
```

### Multiple Monitors

Configure multiple virtual displays:

```xml
<video>
  <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='2' primary='yes'/>
</video>
```

### QXL vs VirtIO-GPU

**QXL**
- Better for SPICE
- Good 2D performance
- Windows driver included

**VirtIO-GPU**
- Modern alternative
- Better 3D support
- Requires VirtIO drivers

## USB Passthrough

### USB Host Device

Pass through a specific USB device:

```xml
<hostdev mode='subsystem' type='usb' managed='yes'>
  <source>
    <vendor id='0x046d'/>
    <product id='0xc52b'/>
  </source>
</hostdev>
```

### USB Controller Passthrough

Pass through entire USB controller:

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source>
    <address domain='0x0000' bus='0x00' slot='0x14' function='0x0'/>
  </source>
</hostdev>
```

### USB Redirection with SPICE

Automatic USB redirection:

```xml
<redirdev bus='usb' type='spicevmc'/>
<redirdev bus='usb' type='spicevmc'/>
<redirdev bus='usb' type='spicevmc'/>
<redirdev bus='usb' type='spicevmc'/>
```

## Audio Configuration

### PulseAudio Passthrough

```xml
<sound model='ich9'>
  <audio id='1'/>
</sound>

<audio id='1' type='pulseaudio' serverName='/run/user/1000/pulse/native'>
  <input mixingEngine='no'/>
  <output mixingEngine='no'/>
</audio>
```

### JACK Audio

For low-latency audio:

```xml
<audio id='1' type='jack'>
  <input clientName='vm-input' connectPorts='system:capture_1'/>
  <output clientName='vm-output' connectPorts='system:playback_1'/>
</audio>
```

## VM Cloning and Templates

### Create Template

```bash
# Create a fully-configured VM
# Install OS and software
# Generalize the system (Windows: sysprep)

# Convert to template
virt-sysprep -d windows11-template
```

### Clone from Template

```bash
virt-clone --original windows11-template \
           --name windows11-clone \
           --file /var/lib/libvirt/images/windows11-clone.qcow2
```

## Snapshots and Backups

### Internal Snapshots

QCOW2 only:

```bash
# Create snapshot
virsh snapshot-create-as windows11 snapshot1 "Before update"

# List snapshots
virsh snapshot-list windows11

# Restore snapshot
virsh snapshot-revert windows11 snapshot1

# Delete snapshot
virsh snapshot-delete windows11 snapshot1
```

### External Snapshots

Works with raw images:

```bash
# Create external snapshot
virsh snapshot-create-as windows11 snapshot1 \
    --disk-only --atomic

# Commit changes back
virsh blockcommit windows11 vda --active --pivot
```

### Full VM Backup

```bash
#!/bin/bash
VM_NAME="windows11"
BACKUP_DIR="/backup/vms"

# Shutdown VM
virsh shutdown $VM_NAME

# Wait for shutdown
while virsh list --all | grep -q "$VM_NAME.*running"; do
    sleep 5
done

# Backup disk and XML
cp /var/lib/libvirt/images/${VM_NAME}.qcow2 $BACKUP_DIR/
virsh dumpxml $VM_NAME > $BACKUP_DIR/${VM_NAME}.xml

# Restart VM
virsh start $VM_NAME
```

## Monitoring and Management

### VM Resource Usage

```bash
# CPU usage
virsh cpu-stats windows11

# Memory usage
virsh dommemstat windows11

# Disk I/O
virsh domblklist windows11
virsh domblkstat windows11 vda

# Network I/O
virsh domifstat windows11 vnet0
```

### Performance Monitoring

```bash
# Top-like tool for VMs
virt-top

# Detailed stats
virsh domstats windows11
```

## Automation

### Autostart VM

```bash
virsh autostart windows11
```

### Systemd Integration

Create a systemd service for VM management:

```ini
[Unit]
Description=Windows 11 VM
After=libvirtd.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/virsh start windows11
ExecStop=/usr/bin/virsh shutdown windows11

[Install]
WantedBy=multi-user.target
```

## Security Considerations

### SELinux Configuration

```bash
# Allow libvirt to access custom image locations
sudo semanage fcontext -a -t virt_image_t "/custom/path(/.*)?"
sudo restorecon -Rv /custom/path
```

### Secure VNC Access

```xml
<graphics type='vnc' port='5900' autoport='no' listen='127.0.0.1' passwd='securepass'>
  <listen type='address' address='127.0.0.1'/>
</graphics>
```

Use SSH tunnel to access:
```bash
ssh -L 5900:localhost:5900 user@host
```

## Troubleshooting

### Enable libvirt logging

```bash
# Edit /etc/libvirt/libvirtd.conf
log_level = 1
log_outputs="1:file:/var/log/libvirt/libvirtd.log"

sudo systemctl restart libvirtd
```

### VM won't start

Check logs:
```bash
sudo journalctl -u libvirtd
tail -f /var/log/libvirt/qemu/windows11.log
```

### Performance issues

Check resource allocation:
```bash
virsh dominfo windows11
virsh vcpuinfo windows11
virsh domstats windows11
```

## Additional Resources

- [KVM Documentation](https://www.linux-kvm.org/)
- [libvirt Documentation](https://libvirt.org/docs.html)
- [QEMU Documentation](https://www.qemu.org/docs/master/)
- [Fedora Virtualization Guide](https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/)
