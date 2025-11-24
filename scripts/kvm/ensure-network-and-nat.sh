#!/bin/bash
# scripts/kvm/ensure-network-and-nat.sh
# Assicura che br0 sia presente (crea via NetworkManager se mancante) e che wifi-nat sia autostart
# USO: sudo ./ensure-network-and-nat.sh <eth-interface>
set -euo pipefail

ETH_IF="${1:-}"
if [[ -z "$ETH_IF" ]]; then
  echo "USO: $0 <eth-interface>     (es. enp3s0)"
  echo "Trova le interfacce con: ip -o link show | awk -F': ' '/en|eth|eno|enp/ {print $2}'"
  exit 1
fi

echo "=== ENSURE NETWORK & NAT ==="
echo "Interface scelta: $ETH_IF"

# crea bridge se non esiste
if ! nmcli connection show br0 &>/dev/null; then
  echo "Creazione bridge br0..."
  nmcli connection add type bridge ifname br0 con-name br0 || true
  nmcli connection add type ethernet ifname "$ETH_IF" con-name br0-slave master br0 || true
  nmcli connection modify br0 connection.autoconnect yes || true
  nmcli connection up br0 || true
  nmcli connection up br0-slave || true
else
  echo "Bridge br0 già esistente"
fi

# Assicura wifi-nat libvirt active e autostart
if sudo virsh net-list --all | grep -q wifi-nat; then
  sudo virsh net-start wifi-nat 2>/dev/null || true
  sudo virsh net-autostart wifi-nat 2>/dev/null || true
  echo "wifi-nat attivata e autostart impostato"
else
  echo "Attenzione: wifi-nat non trovata come rete libvirt. Crea o ripristina la rete NAT se necessario."
fi

echo "=== FINITO ==="