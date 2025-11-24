#!/bin/bash
# scripts/kvm/prepare-template.sh
# Rende temporaneamente il template modificabile (writable) e disabilita l'autostart
# USO: sudo ./prepare-template.sh
set -euo pipefail

TEMPLATE_DISK="/var/lib/libvirt/images/Win11-Template.qcow2"
TEMPLATE_VM="Win11-Template"

echo "=== PREPARE TEMPLATE ==="
echo "1) Verifica esistenza disco template: $TEMPLATE_DISK"
if [[ ! -f "$TEMPLATE_DISK" ]]; then
  echo "ERRORE: disco template non trovato: $TEMPLATE_DISK" >&2
  exit 1
fi

echo "2) Assicuro che il template sia spento"
if sudo virsh domstate "$TEMPLATE_VM" 2>/dev/null | grep -q running; then
  echo "  -> Template in esecuzione: shutdown"
  sudo virsh shutdown "$TEMPLATE_VM" || true
  sleep 5
  sudo virsh destroy "$TEMPLATE_VM" 2>/dev/null || true
fi

echo "3) Disabilita autostart (protezione)"
sudo virsh autostart "$TEMPLATE_VM" --disable || true

echo "4) Rendi scrivibile temporaneamente il file (owner root)"
sudo chown root:root "$TEMPLATE_DISK"
sudo chmod 664 "$TEMPLATE_DISK"
echo " Template ora scrivibile (chmod 664). Dopo le modifiche esegui protect-template.sh"
echo "=== FINITO ==="