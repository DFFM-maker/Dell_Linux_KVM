# GPU Passthrough Guide for KVM on Fedora 43

GPU passthrough allows your Windows 11 VM to use a dedicated GPU for near-native graphics performance, ideal for gaming, video editing, or GPU-intensive applications.

## Prerequisites

- Two GPUs: One for the host (integrated or discrete) and one for passthrough to the VM
- IOMMU support in CPU and motherboard
- Dedicated GPU must support UEFI
- Motherboard with IOMMU grouping support

## Step 1: Verify IOMMU Support

Check if your CPU supports IOMMU:

```bash
# For Intel CPUs (VT-d)
grep -e "Intel" /proc/cpuinfo && dmesg | grep -e "DMAR" -e "IOMMU"

# For AMD CPUs (AMD-Vi)
grep -e "AMD" /proc/cpuinfo && dmesg | grep -e "AMD-Vi"
```

## Step 2: Enable IOMMU in GRUB

Edit GRUB configuration:

```bash
sudo nano /etc/default/grub
```

Add IOMMU kernel parameter to `GRUB_CMDLINE_LINUX`:

For Intel:
```
GRUB_CMDLINE_LINUX="... intel_iommu=on iommu=pt"
```

For AMD:
```
GRUB_CMDLINE_LINUX="... amd_iommu=on iommu=pt"
```

Update GRUB:
```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

Reboot your system.

## Step 3: Verify IOMMU is Enabled

After reboot:

```bash
dmesg | grep -i iommu
```

You should see messages indicating IOMMU is enabled.

## Step 4: Identify GPU IOMMU Group

List all IOMMU groups:

```bash
#!/bin/bash
for d in /sys/kernel/iommu_groups/*/devices/*; do
    n=${d#*/iommu_groups/*}; n=${n%%/*}
    printf 'IOMMU Group %s ' "$n"
    lspci -nns "${d##*/}"
done
```

Find your GPU's IOMMU group. Example output:
```
IOMMU Group 1 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation ...
IOMMU Group 1 01:00.1 Audio device [0403]: NVIDIA Corporation ...
```

Note the PCI IDs (e.g., `10de:1c03` for GPU, `10de:10f1` for audio).

## Step 5: Bind GPU to VFIO Driver

Create a file to bind the GPU to VFIO:

```bash
sudo nano /etc/modprobe.d/vfio.conf
```

Add your GPU's PCI IDs:
```
options vfio-pci ids=10de:1c03,10de:10f1
```

Create a file to load VFIO modules early:

```bash
sudo nano /etc/dracut.conf.d/vfio.conf
```

Add:
```
add_drivers+=" vfio vfio_iommu_type1 vfio_pci "
```

Regenerate initramfs:
```bash
sudo dracut -f --kver $(uname -r)
```

Reboot.

## Step 6: Verify VFIO Binding

After reboot, check if GPU is bound to VFIO:

```bash
lspci -nnk -d 10de:1c03
```

You should see `Kernel driver in use: vfio-pci`.

## Step 7: Configure VM for GPU Passthrough

Edit your VM configuration:

```bash
virsh edit windows11
```

Add the GPU PCI device:

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source>
    <address domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
  </source>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
</hostdev>
```

Also add the GPU's audio device if present.

## Step 8: Hide KVM from Guest (NVIDIA GPU)

NVIDIA drivers block KVM VMs. Add this to your VM XML:

```xml
<features>
  <hyperv mode='custom'>
    <vendor_id state='on' value='1234567890ab'/>
  </hyperv>
  <kvm>
    <hidden state='on'/>
  </kvm>
</features>
```

## Step 9: Configure Video Output

You have two options:

### Option A: Looking Glass (Recommended)
Looking Glass allows you to view VM output on the host without switching displays.

Install Looking Glass:
```bash
sudo dnf install looking-glass-client
```

Add shared memory to VM:
```xml
<shmem name='looking-glass'>
  <model type='ivshmem-plain'/>
  <size unit='M'>32</size>
</shmem>
```

### Option B: Direct Display Output
Connect a monitor directly to the passed-through GPU. The VM will output to that monitor.

## Step 10: Install GPU Drivers in Windows

1. Start the VM
2. Download GPU drivers from manufacturer's website
3. Install drivers in Windows
4. Reboot the VM

## Troubleshooting

### Code 43 Error in Windows

Add vendor ID masking:
```xml
<vendor_id state='on' value='whatever123'/>
```

### Black Screen on VM Start

- Ensure GPU ROM is compatible with UEFI
- Try adding GPU ROM file:
```xml
<rom file='/path/to/gpu.rom'/>
```

### Host Cannot Use GPU After Passthrough

This is expected. The GPU is dedicated to the VM. Use another GPU for the host.

### Performance Issues

- Enable MSI (Message Signaled Interrupts) for the GPU
- Use CPU pinning
- Enable huge pages
- Use host-passthrough CPU mode

## Performance Optimization

Add these to your VM XML:

```xml
<cpu mode='host-passthrough' check='none' migratable='on'>
  <topology sockets='1' dies='1' cores='4' threads='2'/>
  <cache mode='passthrough'/>
  <feature policy='require' name='topoext'/>
</cpu>

<memoryBacking>
  <hugepages/>
</memoryBacking>

<iothreads>1</iothreads>
```

## Testing

Benchmark your GPU in Windows:
- 3DMark
- Heaven Benchmark
- Gaming performance tests

You should see 90-95% of native GPU performance.

## Reverting Passthrough

To use the GPU on the host again:

1. Shut down the VM
2. Remove GPU from VM XML
3. Remove VFIO binding from `/etc/modprobe.d/vfio.conf`
4. Regenerate initramfs: `sudo dracut -f`
5. Reboot

## Additional Resources

- [Arch Linux PCI Passthrough Guide](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF)
- [Level1Techs GPU Passthrough Forum](https://forum.level1techs.com/c/linux/26)
- [r/VFIO Subreddit](https://reddit.com/r/VFIO)

## Dell-Specific Notes

### Dell XPS
- Some XPS models have IOMMU grouping issues
- May require ACS override patch (not recommended for security)

### Dell Precision
- Generally excellent IOMMU support
- Workstation GPUs (Quadro/FirePro) work well

### Dell OptiPlex
- Verify IOMMU support in BIOS (often disabled by default)
- May need BIOS update for better compatibility
