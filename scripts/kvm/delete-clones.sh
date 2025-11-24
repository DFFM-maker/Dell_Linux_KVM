#!/bin/bash
# scripts/kvm/delete-clones.sh
# Elimina in sicurezza le VM clone e rimuove i loro file qcow2 (dry-run opzionale)
# USO:
#   sudo ./delete-clones.sh        -> esecuzione reale
#   sudo ./delete-clones.sh --dry  -> stampa cosa farebbe senza eseguire

set -euo pipefail

DRY_RUN=false
if [[ "${1:-}" == "--dry" ]]; then DRY_RUN=true; fi

TEMPLATE="Win11-Template"
CLONES=( "Win11-Rockwell" "Win11-Omron" "Win11-Office" )

echo "=== DELETE CLONES ==="
echo "Template protetto: $TEMPLATE"
echo "Cloni target: ${CLONES[*]}"
echo "Dry run: $DRY_RUN"
echo

for VM in "${CLONES[@]}"; do
  echo "---- Processing $VM ----"
  if sudo virsh dominfo "$VM" &>/dev/null; then
    STATE=$(sudo virsh domstate "$VM" 2>/dev/null || echo "unknown")
    echo " VM state: $STATE"
    if [[ "$STATE" != "shut off" ]]; then
      echo "  -> Shutdown $VM"
      if [[ "$DRY_RUN" = false ]]; then
        sudo virsh shutdown "$VM" || sudo virsh destroy "$VM"
      else
        echo "   (dry) virsh shutdown $VM  # or destroy if still running"
      fi
      sleep 2
    fi

    echo "  -> Undefine VM (rimuove registro libvirt)"
    if [[ "$DRY_RUN" = false ]]; then
      sudo virsh undefine "$VM" --remove-all-storage || sudo virsh undefine "$VM"
    else
      echo "   (dry) virsh undefine $VM --remove-all-storage"
    fi
  else
    echo "  -> VM $VM non trovata, salto undefine"
  fi

  # rimuovi file disk se esistono e non sono il template
  DISK="/var/lib/libvirt/images/${VM}.qcow2"
  if [[ -f "$DISK" ]]; then
    echo "  -> Rimuovo disco: $DISK"
    if [[ "$DRY_RUN" = false ]]; then
      sudo rm -vf "$DISK"
    else
      echo "   (dry) rm $DISK"
    fi
  else
    echo "  -> Disco $DISK non trovato"
  fi
  echo
done

echo "=== DONE ==="