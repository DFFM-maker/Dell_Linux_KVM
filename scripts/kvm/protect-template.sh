#!/bin/bash
# scripts/kvm/protect-template.sh
# Protegge il template rendendo il file read-only e disabilita l'avvio
# USO: sudo ./protect-template.sh
set -euo pipefail

TEMPLATE_DISK="/var/lib/libvirt/images/Win11-Template.qcow2"
TEMPLATE_VM="Win11-Template"

echo "=== PROTECT TEMPLATE ==="
if [[ ! -f "$TEMPLATE_DISK" ]]; then
  echo "ERRORE: disco template non trovato: $TEMPLATE_DISK" >&2
  exit 1
fi

# Assicurati template spento
if sudo virsh domstate "$TEMPLATE_VM" 2>/dev/null | grep -q running; then
  echo "Template in esecuzione: forzo destroy"
  sudo virsh destroy "$TEMPLATE_VM" || true
fi

sudo virsh autostart "$TEMPLATE_VM" --disable || true
sudo chown root:root "$TEMPLATE_DISK"
sudo chmod 444 "$TEMPLATE_DISK"
echo " Template protetto: chmod 444 e autostart disabilitato"
echo " Se devi modificare: chmod 664 e ri-abilita temporaneamente"
echo "=== FINITO ==="