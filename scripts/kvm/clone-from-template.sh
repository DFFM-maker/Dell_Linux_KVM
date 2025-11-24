#!/bin/bash
# Clone VM da template
set -e

TEMPLATE="Win11-Template"
NEW_VM_NAME=$1
NEW_VM_RAM=${2:-16384}
NEW_VM_VCPUS=${3:-6}

if [[ -z "$NEW_VM_NAME" ]]; then
    echo "Usage: $0 <vm-name> [ram-mb] [vcpus]"
    echo "Example: $0 Win11-Rockwell 16384 6"
    exit 1
fi

TEMPLATE_DISK="/var/lib/libvirt/images/${TEMPLATE}.qcow2"
NEW_DISK="/var/lib/libvirt/images/${NEW_VM_NAME}.qcow2"

echo "🔄 Clonazione da Template"
echo "========================="
echo "Template: $TEMPLATE"
echo "Nuova VM: $NEW_VM_NAME"
echo "RAM: ${NEW_VM_RAM}MB ($(($NEW_VM_RAM/1024))GB)"
echo "CPU: $NEW_VM_VCPUS cores"
echo ""

# Verifica template
if ! sudo virsh dominfo "$TEMPLATE" &>/dev/null; then
    echo "❌ Template non trovato!"
    exit 1
fi

# Disco COW (Copy-on-Write)
echo "📀 Creazione disco COW..."
sudo qemu-img create -f qcow2 -F qcow2 -b "$TEMPLATE_DISK" "$NEW_DISK"

# Clone VM
echo "🖥️  Clonazione VM..."
sudo virt-clone \
  --original "$TEMPLATE" \
  --name "$NEW_VM_NAME" \
  --file "$NEW_DISK" \
  --preserve-data

# Configura risorse
echo "⚙️  Configurazione risorse..."
sudo virsh setmaxmem "$NEW_VM_NAME" "${NEW_VM_RAM}k" --config
sudo virsh setmem "$NEW_VM_NAME" "${NEW_VM_RAM}k" --config
sudo virsh setvcpus "$NEW_VM_NAME" "$NEW_VM_VCPUS" --maximum --config
sudo virsh setvcpus "$NEW_VM_NAME" "$NEW_VM_VCPUS" --config

echo ""
echo "✅ VM $NEW_VM_NAME clonata con successo!"
echo ""
echo "📊 Info disco:"
sudo qemu-img info "$NEW_DISK" | grep -E "(virtual size|disk size|backing file)"
echo ""
echo "🎮 Avvia con:"
echo "   sudo virsh start $NEW_VM_NAME"
echo "   virt-manager"
