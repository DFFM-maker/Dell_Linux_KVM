#!/bin/bash
# VM Template Windows 11 - PERFORMANCE OTTIMIZZATE
set -e

VM_NAME="Win11-Template"
VM_RAM=12288
VM_VCPUS=4
VM_DISK_SIZE=120
ISO_PATH="$HOME/Iso/Win11_25H2_Italian_x64.iso"
VIRTIO_ISO="$HOME/Iso/virtio-win.iso"
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"

echo "🎨 VM Template - Configurazione PERFORMANCE"
echo "==========================================="

for ISO in "$ISO_PATH" "$VIRTIO_ISO"; do
    [[ ! -f "$ISO" ]] && echo "❌ $ISO non trovata" && exit 1
done

if ip link show br0 &>/dev/null; then
    NETWORK_BRIDGE="--network bridge=br0,model=virtio"
else
    NETWORK_BRIDGE=""
    echo "⚠️  br0 non trovato, solo NAT"
fi

echo "📦 RAM: $(($VM_RAM/1024))GB | CPU: $VM_VCPUS | Disk: ${VM_DISK_SIZE}GB"
echo "🎮 Video: virtio (2D accelerato, no OpenGL)"
echo ""

sudo virt-install \
  --name "$VM_NAME" \
  --memory "$VM_RAM" \
  --vcpus "$VM_VCPUS",maxvcpus=8 \
  --cpu host-passthrough,cache.mode=passthrough \
  --disk path="$DISK_PATH",size="$VM_DISK_SIZE",format=qcow2,bus=virtio,cache=writeback,io=threads \
  $NETWORK_BRIDGE \
  --network network=wifi-nat,model=virtio \
  --cdrom "$ISO_PATH" \
  --disk path="$VIRTIO_ISO",device=cdrom \
  --graphics spice,listen=none \
  --video virtio \
  --channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
  --console pty,target_type=serial \
  --sound none \
  --boot uefi \
  --tpm backend.type=emulator,backend.version=2.0 \
  --features kvm_hidden=on,smm=on \
  --clock offset=localtime \
  --os-variant win11 \
  --noautoconsole

echo ""
echo "✅ VM Template creata con successo!"
echo ""
echo "📋 Performance ottimizzate per:"
echo "   ✓ Studio5000 / FactoryTalk"
echo "   ✓ Sysmac Studio"
echo "   ✓ Machine Expert"
echo "   ✓ Software industriale generale"
echo ""
echo "🎮 Avvia: virt-manager"
