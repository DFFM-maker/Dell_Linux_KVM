#!/bin/bash
set -euo pipefail

DRY=false
if [[ "${1:-}" == "--dry" ]]; then DRY=true; fi

CLONES=( "Win11-Rockwell" "Win11-Omron" "Win11-Office" )
BACKUP_DIR="/var/lib/libvirt/backup-clones-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Backup files and XML will be stored in: $BACKUP_DIR"
echo "Dry run: $DRY"
echo

for VM in "${CLONES[@]}"; do
  echo "========================"
  echo "Processing: $VM"
  echo "========================"

  if ! sudo virsh dominfo "$VM" &>/dev/null; then
    echo "  -> VM $VM non trovata in libvirt, controllo files residui..."
    sudo ls -lh /etc/libvirt/qemu/${VM}.xml /var/lib/libvirt/images/${VM}.qcow2 /var/lib/libvirt/qemu/nvram/${VM}_VARS.qcow2 2>/dev/null || true
    echo
    continue
  fi

  # dump xml backup
  echo "  -> Dump XML to $BACKUP_DIR/${VM}.xml"
  sudo virsh dumpxml "$VM" > "$BACKUP_DIR/${VM}.xml"

  # find nvram path in xml
  NVPATH=$(sudo sed -n '/<nvram/,/<\/nvram>/p' "$BACKUP_DIR/${VM}.xml" | sed -n 's/.*>\(.*\)<.*/\1/p' || true)
  if [[ -n "$NVPATH" ]]; then
    echo "  -> NVMe/NVRAM detected: $NVPATH"
    if [[ -f "$NVPATH" ]]; then
      echo "     backing up nvram to $BACKUP_DIR/"
      if [[ "$DRY" = false ]]; then
        sudo cp -v "$NVPATH" "$BACKUP_DIR/" || true
      else
        echo "     (dry) cp $NVPATH $BACKUP_DIR/"
      fi
    else
      echo "     nvram file not found on disk: $NVPATH"
    fi
  else
    echo "  -> No <nvram> tag found in XML"
  fi

  # attempt undefine with nvram removal
  echo "  -> Trying: virsh undefine $VM --remove-all-storage --nvram"
  if [[ "$DRY" = false ]]; then
    if sudo virsh undefine "$VM" --remove-all-storage --nvram 2>/tmp/${VM}_undef_err.log; then
      echo "  -> Undefine OK for $VM (with --nvram)"
      # storage should be removed by virsh; ensure disk/nvram cleanup below
    else
      echo "  -> undefine with --nvram FAILED, check /tmp/${VM}_undef_err.log"
      echo "     Fallback: remove <nvram> from XML, redefine and undefine"
      # fallback: remove nvram tag from xml and redefine
      TMPXML="/tmp/${VM}_no_nvram.xml"
      sudo cp -v "$BACKUP_DIR/${VM}.xml" "$TMPXML"
      sudo sed -i '/<nvram/,/<\/nvram>/d' "$TMPXML"
      echo "     -> redefining VM without nvram"
      sudo virsh define "$TMPXML"
      echo "     -> now undefine with remove-all-storage"
      sudo virsh undefine "$VM" --remove-all-storage || true
      sudo rm -f "$TMPXML"
    fi
  else
    echo "   (dry) virsh undefine $VM --remove-all-storage --nvram"
  fi

  # Remove leftover nvram file if present (not the backed-up copy)
  if [[ -n "$NVPATH" && -f "$NVPATH" ]]; then
    echo "  -> Removing nvram file: $NVPATH"
    if [[ "$DRY" = false ]]; then sudo rm -vf "$NVPATH" || true; else echo "   (dry) rm $NVPATH"; fi
  fi

  # Remove disk file if still present and it's not the template
  DISK="/var/lib/libvirt/images/${VM}.qcow2"
  if [[ -f "$DISK" ]]; then
    echo "  -> Removing disk file: $DISK"
    if [[ "$DRY" = false ]]; then sudo rm -vf "$DISK" || true; else echo "   (dry) rm $DISK"; fi
  fi

  # Remove any leftover xml in /etc/libvirt/qemu
  QXML="/etc/libvirt/qemu/${VM}.xml"
  if [[ -f "$QXML" ]]; then
    echo "  -> Removing libvirt xml: $QXML"
    if [[ "$DRY" = false ]]; then sudo rm -vf "$QXML" || true; else echo "   (dry) rm $QXML"; fi
  fi

  echo "  -> Finished $VM"
  echo
done

echo "All done. Backup dir: $BACKUP_DIR"
echo "List remaining files:"
ls -lh /var/lib/libvirt/images/Win11-*.qcow2 2>/dev/null || true
ls -lh /var/lib/libvirt/qemu/nvram/Win11-* 2>/dev/null || true
sudo virsh list --all
