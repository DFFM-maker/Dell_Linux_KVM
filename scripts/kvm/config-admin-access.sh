#!/bin/bash
# scripts/kvm/config-admin-access.sh
# Aggiunge l'utente admin ai gruppi libvirt/kvm e crea la regola polkit per permettere l'uso di virt-manager senza sudo
# USO: sudo ./config-admin-access.sh admin
set -euo pipefail

USER_TO_ADD="${1:-admin}"

echo "=== CONFIG ADMIN ACCESS ==="
echo "Utente da aggiungere: $USER_TO_ADD"

# aggiungi ai gruppi
sudo usermod -aG libvirt,kvm "$USER_TO_ADD"
echo "Utente $USER_TO_ADD aggiunto ai gruppi libvirt,kvm"

# Crea polkit rule
POLKIT_FILE="/etc/polkit-1/rules.d/49-libvirt.rules"
cat > "$POLKIT_FILE" <<'POL'
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("libvirt")) {
        return polkit.Result.YES;
    }
});
POL
chmod 644 "$POLKIT_FILE"
echo "Regola polkit creata in $POLKIT_FILE"

echo "Riavvia il daemon libvirt: systemctl restart libvirtd virtlogd"
echo "L'utente deve fare logout/login per applicare i gruppi (o eseguire newgrp libvirt)"
echo "=== FINITO ==="