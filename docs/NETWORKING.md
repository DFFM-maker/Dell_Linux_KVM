# KVM Networking Setup Guide

Complete guide for setting up various network configurations for KVM VMs on Fedora 43.

## Default NAT Network

The default network provides NAT-based connectivity. VMs can access external networks, but are not directly accessible from outside.

### Configuration

Default network is automatically created by libvirt:

```bash
virsh net-list --all
virsh net-info default
```

View configuration:
```bash
virsh net-dumpxml default
```

### Usage in VM

```xml
<interface type='network'>
  <source network='default'/>
  <model type='virtio'/>
</interface>
```

### Advantages
- Easy setup
- VMs are isolated from external network
- No configuration needed

### Disadvantages
- VMs not directly accessible from external network
- Port forwarding needed for services

## Bridged Network

Bridged networking connects VMs directly to your physical network, giving them their own IP addresses.

### Setup

1. Identify your network interface:
```bash
ip link show
```

2. Create bridge using NetworkManager:

```bash
# For wired connection
sudo nmcli connection add type bridge ifname br0 stp no
sudo nmcli connection add type bridge-slave ifname enp0s3 master br0

# Bring up the bridge
sudo nmcli connection up bridge-br0
```

3. Configure in libvirt:

```bash
cat > /tmp/bridge.xml << EOF
<network>
  <name>bridge0</name>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
EOF

virsh net-define /tmp/bridge.xml
virsh net-start bridge0
virsh net-autostart bridge0
```

4. Use in VM:

```xml
<interface type='bridge'>
  <source bridge='br0'/>
  <model type='virtio'/>
</interface>
```

### Advantages
- VMs get IP from DHCP server
- VMs accessible from network
- Near-native performance

### Disadvantages
- More complex setup
- May not work with WiFi
- Security considerations

## Routed Network

Routed mode routes traffic between VMs and physical network.

### Configuration

```xml
<network>
  <name>routed</name>
  <forward mode='route'/>
  <bridge name='virbr1' stp='on' delay='0'/>
  <ip address='192.168.100.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.100.100' end='192.168.100.200'/>
    </dhcp>
  </ip>
</network>
```

Define and start:
```bash
virsh net-define /tmp/routed.xml
virsh net-start routed
virsh net-autostart routed
```

## Isolated Network

Isolated network allows VM-to-VM communication without external access.

### Configuration

```xml
<network>
  <name>isolated</name>
  <bridge name='virbr2' stp='on' delay='0'/>
  <ip address='192.168.200.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.200.10' end='192.168.200.100'/>
    </dhcp>
  </ip>
</network>
```

```bash
virsh net-define /tmp/isolated.xml
virsh net-start isolated
virsh net-autostart isolated
```

## MacVTap Network

MacVTap provides high-performance networking with minimal overhead.

### Direct Mode

```xml
<interface type='direct'>
  <source dev='enp0s3' mode='bridge'/>
  <model type='virtio'/>
</interface>
```

### Modes

- **bridge**: VM appears as separate device on network
- **vepa**: Requires VEPA-capable switch
- **private**: VMs on same host can't communicate
- **passthrough**: Dedicated NIC for VM

## SR-IOV (Single Root I/O Virtualization)

For high-performance networking with hardware support.

### Prerequisites

- SR-IOV capable NIC
- IOMMU enabled

### Setup

1. Enable SR-IOV:

```bash
# Check if SR-IOV is supported
lspci -vvv | grep -i SR-IOV

# Enable virtual functions
echo 4 > /sys/class/net/enp0s3/device/sriov_numvfs

# Make persistent
echo "echo 4 > /sys/class/net/enp0s3/device/sriov_numvfs" >> /etc/rc.local
chmod +x /etc/rc.local
```

2. Assign VF to VM:

```xml
<interface type='hostdev' managed='yes'>
  <source>
    <address type='pci' domain='0x0000' bus='0x03' slot='0x10' function='0x0'/>
  </source>
</interface>
```

## Port Forwarding (NAT Network)

Forward ports from host to VM.

### Using iptables

```bash
# Forward host port 8080 to VM port 80
sudo iptables -I FORWARD -o virbr0 -p tcp -d 192.168.122.100 --dport 80 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p tcp --dport 8080 -j DNAT --to 192.168.122.100:80

# Save rules (Fedora)
sudo iptables-save > /etc/sysconfig/iptables
```

### Using firewalld

```bash
# Add forwarding rule
sudo firewall-cmd --permanent --direct --add-rule ipv4 nat PREROUTING 0 \
    -p tcp --dport 8080 -j DNAT --to 192.168.122.100:80

sudo firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 \
    -p tcp -d 192.168.122.100 --dport 80 -j ACCEPT

sudo firewall-cmd --reload
```

### Using libvirt hooks

Create `/etc/libvirt/hooks/qemu`:

```bash
#!/bin/bash
VM_NAME="$1"
OPERATION="$2"

if [ "$VM_NAME" == "windows11" ] && [ "$OPERATION" == "started" ]; then
    # Forward RDP port
    iptables -I FORWARD -o virbr0 -p tcp -d 192.168.122.100 --dport 3389 -j ACCEPT
    iptables -t nat -I PREROUTING -p tcp --dport 3389 -j DNAT --to 192.168.122.100:3389
fi

if [ "$VM_NAME" == "windows11" ] && [ "$OPERATION" == "stopped" ]; then
    # Remove forwarding rules
    iptables -D FORWARD -o virbr0 -p tcp -d 192.168.122.100 --dport 3389 -j ACCEPT
    iptables -t nat -D PREROUTING -p tcp --dport 3389 -j DNAT --to 192.168.122.100:3389
fi
```

Make executable:
```bash
sudo chmod +x /etc/libvirt/hooks/qemu
```

## Static IP for VMs

Assign static IP to VM in NAT network.

### Method 1: DHCP Reservation

```bash
virsh net-edit default
```

Add host entry:
```xml
<network>
  ...
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.100' end='192.168.122.200'/>
      <host mac='52:54:00:6c:3c:01' name='windows11' ip='192.168.122.100'/>
    </dhcp>
  </ip>
</network>
```

Restart network:
```bash
virsh net-destroy default
virsh net-start default
```

### Method 2: Static in Guest

Configure static IP inside Windows 11 VM:
1. Open Network Settings
2. Change adapter settings
3. Set manual IP configuration
4. IP: 192.168.122.100
5. Gateway: 192.168.122.1
6. DNS: 192.168.122.1 (or 8.8.8.8)

## Multiple Network Interfaces

VMs can have multiple NICs for different purposes.

### Configuration

```xml
<interface type='network'>
  <source network='default'/>
  <model type='virtio'/>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
</interface>

<interface type='bridge'>
  <source bridge='br0'/>
  <model type='virtio'/>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
</interface>
```

## Network Performance Tuning

### Multi-queue VirtIO

Enable multiple TX/RX queues:

```xml
<interface type='network'>
  <source network='default'/>
  <model type='virtio'/>
  <driver name='vhost' queues='4'/>
</interface>
```

Match queue count to VM vCPU count for best performance.

### Offload Features

Enable TCP/UDP offload:

```xml
<interface type='network'>
  <source network='default'/>
  <model type='virtio'/>
  <driver name='vhost'>
    <host csum='on' gso='on' tso4='on' tso6='on' ecn='on' ufo='on'/>
    <guest csum='on' tso4='on' tso6='on' ecn='on' ufo='on'/>
  </driver>
</interface>
```

### vhost-net

Ensure vhost-net is used for better performance:

```bash
# Check if vhost-net is loaded
lsmod | grep vhost_net

# Load if not present
sudo modprobe vhost-net
```

## Firewall Configuration

### Allow libvirt in firewalld

```bash
sudo firewall-cmd --permanent --add-service=libvirt
sudo firewall-cmd --permanent --zone=libvirt --set-target=ACCEPT
sudo firewall-cmd --reload
```

### Custom zones

Create zone for VM network:

```bash
sudo firewall-cmd --permanent --new-zone=vmnet
sudo firewall-cmd --permanent --zone=vmnet --add-source=192.168.122.0/24
sudo firewall-cmd --permanent --zone=vmnet --set-target=ACCEPT
sudo firewall-cmd --reload
```

## VPN Connectivity

### Host VPN + VM Access

When host is on VPN, VMs can access VPN network through NAT.

No special configuration needed if using NAT network.

### VM VPN Client

Install VPN client in Windows VM for independent VPN connection.

### Bridge Mode VPN Issues

Some VPNs block bridged traffic. Use:
- NAT network instead
- VPN directly in VM
- Split tunneling

## DNS Configuration

### libvirt DNS Server

libvirt provides DNS for NAT networks:

```bash
# Query VM by hostname
nslookup windows11 192.168.122.1
```

### Custom DNS

Edit network XML:

```xml
<network>
  ...
  <dns>
    <host ip='192.168.122.100'>
      <hostname>windows11.local</hostname>
    </host>
    <forwarder addr='8.8.8.8'/>
    <forwarder addr='8.8.4.4'/>
  </dns>
  ...
</network>
```

## IPv6 Configuration

Enable IPv6 in virtual network:

```xml
<network>
  <name>default</name>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    ...
  </ip>
  <ip family='ipv6' address='fd00:dead:beef::1' prefix='64'>
    <dhcp>
      <range start='fd00:dead:beef::100' end='fd00:dead:beef::1ff'/>
    </dhcp>
  </ip>
</network>
```

## Network Troubleshooting

### Check Network Status

```bash
# List all networks
virsh net-list --all

# Check network details
virsh net-info default

# Check if network is active
virsh net-dumpxml default | grep -i active
```

### Restart Network

```bash
virsh net-destroy default
virsh net-start default
```

### Check VM Network

```bash
# List VM interfaces
virsh domiflist windows11

# Check interface stats
virsh domifstat windows11 vnet0
```

### Check Bridge

```bash
# List bridge interfaces
brctl show

# Check bridge details
ip link show virbr0
```

### Test Connectivity

From host to VM:
```bash
ping 192.168.122.100
```

From VM to host:
```bash
ping 192.168.122.1
```

From VM to internet:
```bash
ping 8.8.8.8
```

### Common Issues

**VM can't access internet**
- Check if forwarding is enabled: `sysctl net.ipv4.ip_forward`
- Check firewall rules
- Check NAT rules: `iptables -t nat -L`

**Can't ping VM from host**
- Check VM firewall (Windows Firewall)
- Verify VM IP: `ip addr` (in VM)
- Check if VM is on correct network

**Poor network performance**
- Use VirtIO network driver
- Enable multi-queue
- Check host network performance
- Use bridged network for best performance

## Monitoring Network

### Real-time monitoring

```bash
# Monitor specific VM
watch -n 1 'virsh domifstat windows11 vnet0'

# Network top
iftop -i virbr0
```

### Bandwidth limiting

Limit VM network bandwidth:

```xml
<interface type='network'>
  <source network='default'/>
  <model type='virtio'/>
  <bandwidth>
    <inbound average='1024' peak='2048' burst='256'/>
    <outbound average='512' peak='1024' burst='128'/>
  </bandwidth>
</interface>
```

Values in KB/s.

## Additional Resources

- [libvirt Networking](https://wiki.libvirt.org/page/Networking)
- [Linux Bridge Configuration](https://wiki.archlinux.org/title/Network_bridge)
- [VirtIO Network](https://www.linux-kvm.org/page/Virtio)
