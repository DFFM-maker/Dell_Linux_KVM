#!/bin/bash
# Fix lock disco template
set -e

echo "🔧 FIX LOCK DISCO TEMPLATE"
echo "=========================="
echo ""

# 1. Stop tutte le VM
echo "1️⃣ Stop tutte le VM..."
for VM in Win11-Template Win11-Rockwell Win11-Omron Win11-Office; do
    sudo virsh destroy $VM 2>/dev/null && echo "  Fermata: $VM" || true
done

sleep 5

# 2. Verifica stato
echo ""
echo "2️⃣ Verifica stato VM..."
sudo virsh list --all

# 3. Uccidi QEMU zombie
echo ""
echo "3️⃣ Pulizia processi QEMU..."
QEMU_PIDS=$(ps aux | grep "[q]emu-system-x86_64" | awk '{print $2}')
if [[ -n "$QEMU_PIDS" ]]; then
    echo "  Trovati processi zombie: $QEMU_PIDS"
    sudo kill -9 $QEMU_PIDS 2>/dev/null || true
else
    echo "  ✅ Nessun processo zombie"
fi

# 4. Verifica lock
echo ""
echo "4️⃣ Verifica lock disco..."
LOCK_FILES=$(sudo find /var/lib/libvirt/images -name "*.lock" 2>/dev/null)
if [[ -n "$LOCK_FILES" ]]; then
    echo "  ⚠️  Lock files trovati:"
    echo "$LOCK_FILES"
    sudo rm -f /var/lib/libvirt/images/*.lock
    echo "  ✅ Lock rimossi"
else
    echo "  ✅ Nessun lock presente"
fi

# 5. Verifica processi con file aperti
echo ""
echo "5️⃣ Verifica file aperti..."
if command -v lsof &>/dev/null; then
    OPEN_FILES=$(sudo lsof /var/lib/libvirt/images/*.qcow2 2>/dev/null | tail -n +2)
    if [[ -n "$OPEN_FILES" ]]; then
        echo "  ⚠️  File ancora aperti:"
        echo "$OPEN_FILES"
    else
        echo "  ✅ Nessun file aperto"
    fi
fi

# 6. Riavvia libvirtd
echo ""
echo "6️⃣ Riavvio libvirtd..."
sudo systemctl restart libvirtd
sleep 3

# 7. Disabilita avvio template
echo ""
echo "7️⃣ Proteggi template da avvio accidentale..."
sudo virsh autostart Win11-Template --disable 2>/dev/null || true

# 8. Verifica backing file
echo ""
echo "8️⃣ Verifica integrità backing files..."
for VM in Win11-Rockwell Win11-Omron Win11-Office; do
    DISK="/var/lib/libvirt/images/${VM}.qcow2"
    if [[ -f "$DISK" ]]; then
        BACKING=$(sudo qemu-img info "$DISK" | grep "backing file:")
        if [[ -n "$BACKING" ]]; then
            echo "  ✅ $VM: $BACKING"
        else
            echo "  ❌ $VM: Backing file mancante!"
        fi
    fi
done

echo ""
echo "✅ FIX COMPLETATO!"
echo ""
echo "🎮 Avvia VM clonate:"
echo "   sudo virsh start Win11-Rockwell"
echo "   sudo virsh start Win11-Omron"
echo "   sudo virsh start Win11-Office"
echo ""
echo "⚠️  NON avviare Win11-Template (è la base per le clonate!)"
