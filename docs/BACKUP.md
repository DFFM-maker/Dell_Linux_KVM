# Backup and Snapshots Guide

Complete guide for backing up KVM virtual machines and creating snapshots on Fedora 43.

## Understanding VM Backups

### Components to Backup

1. **Disk images**: `/var/lib/libvirt/images/`
2. **VM XML definition**: `virsh dumpxml <vm-name>`
3. **NVRAM (UEFI vars)**: `/var/lib/libvirt/qemu/nvram/`
4. **VM metadata**: Custom scripts, notes, etc.

## Snapshots

Snapshots capture VM state at a point in time.

### Internal Snapshots (QCOW2 only)

Internal snapshots store snapshot data within the QCOW2 image.

#### Create Snapshot

```bash
# Create snapshot with description
virsh snapshot-create-as windows11 \
    snapshot1 \
    "Before Windows Update - $(date '+%Y-%m-%d %H:%M')" \
    --atomic

# Create snapshot of running VM (includes memory state)
virsh snapshot-create-as windows11 \
    snapshot-live \
    "Live snapshot with memory" \
    --live \
    --atomic
```

#### List Snapshots

```bash
# List all snapshots
virsh snapshot-list windows11

# List with more details
virsh snapshot-list windows11 --tree
```

#### View Snapshot Details

```bash
virsh snapshot-info windows11 snapshot1
virsh snapshot-dumpxml windows11 snapshot1
```

#### Restore Snapshot

```bash
# Revert to snapshot (VM will be shut down first if running)
virsh snapshot-revert windows11 snapshot1

# Revert running VM
virsh snapshot-revert windows11 snapshot1 --running
```

#### Delete Snapshot

```bash
# Delete single snapshot
virsh snapshot-delete windows11 snapshot1

# Delete snapshot and its children
virsh snapshot-delete windows11 snapshot1 --children
```

### External Snapshots

External snapshots work with any disk format (qcow2, raw, LVM).

#### Create External Snapshot

```bash
# Disk-only external snapshot
virsh snapshot-create-as windows11 \
    external-snapshot \
    "External snapshot - $(date '+%Y-%m-%d')" \
    --disk-only \
    --atomic

# This creates a new overlay file
# Original disk becomes read-only backing file
```

#### List Active Disk Chain

```bash
virsh domblklist windows11 --details
```

#### Commit Changes (Merge Snapshots)

```bash
# Commit all changes from snapshot back to base image
virsh blockcommit windows11 vda --active --pivot --verbose

# Commit specific snapshot
virsh blockcommit windows11 vda --base /path/to/base.qcow2 --top /path/to/snapshot.qcow2 --pivot
```

#### Pull Changes (Alternative merge method)

```bash
# Pull changes from child to parent
virsh blockpull windows11 vda --wait --verbose
```

### Snapshot Strategies

#### Regular Snapshots Before Changes

```bash
#!/bin/bash
# pre-update-snapshot.sh

VM_NAME="windows11"
SNAPSHOT_NAME="pre-update-$(date +%Y%m%d-%H%M%S)"

echo "Creating snapshot: $SNAPSHOT_NAME"
virsh snapshot-create-as $VM_NAME \
    "$SNAPSHOT_NAME" \
    "Automatic snapshot before updates" \
    --atomic

echo "Snapshot created successfully"
virsh snapshot-list $VM_NAME --tree
```

#### Automatic Cleanup Old Snapshots

```bash
#!/bin/bash
# cleanup-old-snapshots.sh

VM_NAME="windows11"
KEEP_SNAPSHOTS=5

# Get list of snapshots sorted by creation time
SNAPSHOTS=$(virsh snapshot-list $VM_NAME --name | sort)
SNAPSHOT_COUNT=$(echo "$SNAPSHOTS" | wc -l)

if [ $SNAPSHOT_COUNT -gt $KEEP_SNAPSHOTS ]; then
    DELETE_COUNT=$((SNAPSHOT_COUNT - KEEP_SNAPSHOTS))
    TO_DELETE=$(echo "$SNAPSHOTS" | head -n $DELETE_COUNT)
    
    for snapshot in $TO_DELETE; do
        echo "Deleting old snapshot: $snapshot"
        virsh snapshot-delete $VM_NAME $snapshot
    done
fi
```

## Full VM Backups

### Method 1: Offline Backup (Safest)

```bash
#!/bin/bash
# backup-vm-offline.sh

VM_NAME="windows11"
BACKUP_DIR="/backup/vms/$(date +%Y%m%d)"
VM_IMAGE_DIR="/var/lib/libvirt/images"
NVRAM_DIR="/var/lib/libvirt/qemu/nvram"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Shutdown VM
echo "Shutting down VM: $VM_NAME"
virsh shutdown $VM_NAME

# Wait for shutdown (timeout after 300 seconds)
TIMEOUT=300
ELAPSED=0
while virsh list | grep -q "$VM_NAME.*running"; do
    sleep 5
    ELAPSED=$((ELAPSED + 5))
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "Timeout waiting for shutdown, forcing off..."
        virsh destroy $VM_NAME
        break
    fi
done

echo "VM shutdown complete"

# Backup disk image
echo "Backing up disk image..."
cp -v "$VM_IMAGE_DIR/${VM_NAME}.qcow2" "$BACKUP_DIR/"

# Backup XML definition
echo "Backing up XML definition..."
virsh dumpxml $VM_NAME > "$BACKUP_DIR/${VM_NAME}.xml"

# Backup NVRAM if exists
if [ -f "$NVRAM_DIR/${VM_NAME}_VARS.fd" ]; then
    echo "Backing up NVRAM..."
    cp -v "$NVRAM_DIR/${VM_NAME}_VARS.fd" "$BACKUP_DIR/"
fi

# Create backup manifest
cat > "$BACKUP_DIR/backup-manifest.txt" << EOF
Backup Date: $(date)
VM Name: $VM_NAME
Disk Image: ${VM_NAME}.qcow2
XML Definition: ${VM_NAME}.xml
NVRAM: ${VM_NAME}_VARS.fd
Backup Size: $(du -sh "$BACKUP_DIR" | cut -f1)
EOF

# Restart VM
echo "Starting VM: $VM_NAME"
virsh start $VM_NAME

echo "Backup complete: $BACKUP_DIR"
```

### Method 2: Online Backup (With Snapshots)

```bash
#!/bin/bash
# backup-vm-online.sh

VM_NAME="windows11"
BACKUP_DIR="/backup/vms/$(date +%Y%m%d)"
SNAPSHOT_NAME="backup-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$BACKUP_DIR"

echo "Creating snapshot for online backup..."
virsh snapshot-create-as $VM_NAME $SNAPSHOT_NAME --disk-only --atomic

# Get the backing file (original disk)
BACKING_FILE=$(virsh domblklist $VM_NAME --details | grep qcow2 | awk '{print $4}')

echo "Backing up original disk (now read-only)..."
cp "$BACKING_FILE" "$BACKUP_DIR/"

echo "Committing snapshot back..."
virsh blockcommit $VM_NAME vda --active --pivot

echo "Backing up XML..."
virsh dumpxml $VM_NAME > "$BACKUP_DIR/${VM_NAME}.xml"

echo "Online backup complete: $BACKUP_DIR"
```

### Method 3: Compressed Backup

```bash
#!/bin/bash
# backup-vm-compressed.sh

VM_NAME="windows11"
BACKUP_FILE="/backup/vms/${VM_NAME}-$(date +%Y%m%d).tar.gz"
VM_IMAGE_DIR="/var/lib/libvirt/images"

echo "Shutting down VM..."
virsh shutdown $VM_NAME

# Wait for shutdown
while virsh list | grep -q "$VM_NAME.*running"; do
    sleep 5
done

echo "Creating compressed backup..."
tar czf "$BACKUP_FILE" \
    -C "$VM_IMAGE_DIR" "${VM_NAME}.qcow2" \
    --transform="s|^|${VM_NAME}/|"

# Add XML to backup
virsh dumpxml $VM_NAME | gzip >> "$BACKUP_FILE.xml.gz"

echo "Starting VM..."
virsh start $VM_NAME

echo "Compressed backup complete: $BACKUP_FILE"
echo "Size: $(du -h $BACKUP_FILE | cut -f1)"
```

## Incremental Backups

### Using virtnbdbackup (Recommended)

Install virtnbdbackup:
```bash
pip3 install virtnbdbackup
```

Create full backup:
```bash
virtnbdbackup -d windows11 -l full -o /backup/vms/full/
```

Create incremental backup:
```bash
virtnbdbackup -d windows11 -l inc -o /backup/vms/incremental/
```

Restore from backup:
```bash
virtnbdrestore -i /backup/vms/full/ -o /var/lib/libvirt/images/windows11-restored.qcow2
```

### Using rsync for Incremental

```bash
#!/bin/bash
# incremental-backup.sh

VM_NAME="windows11"
SOURCE_IMAGE="/var/lib/libvirt/images/${VM_NAME}.qcow2"
BACKUP_BASE="/backup/vms/incremental"
CURRENT_BACKUP="$BACKUP_BASE/$(date +%Y%m%d)"

# Shutdown VM
virsh shutdown $VM_NAME
while virsh list | grep -q "$VM_NAME.*running"; do sleep 5; done

# Incremental backup with rsync
mkdir -p "$CURRENT_BACKUP"
rsync -av --link-dest="$BACKUP_BASE/latest" \
    "$SOURCE_IMAGE" "$CURRENT_BACKUP/"

# Update 'latest' symlink
rm -f "$BACKUP_BASE/latest"
ln -s "$CURRENT_BACKUP" "$BACKUP_BASE/latest"

# Restart VM
virsh start $VM_NAME

echo "Incremental backup completed: $CURRENT_BACKUP"
```

## Cloning VMs

### Clone Entire VM

```bash
# Clone VM with new disk
virt-clone \
    --original windows11 \
    --name windows11-clone \
    --file /var/lib/libvirt/images/windows11-clone.qcow2

# Clone with auto-generated name
virt-clone --original windows11 --auto-clone
```

### Clone Disk Only

```bash
# Copy and convert disk
qemu-img convert -O qcow2 \
    /var/lib/libvirt/images/windows11.qcow2 \
    /var/lib/libvirt/images/windows11-clone.qcow2

# Clone with compression
qemu-img convert -O qcow2 -c \
    /var/lib/libvirt/images/windows11.qcow2 \
    /var/lib/libvirt/images/windows11-compressed.qcow2
```

## Restoring VMs

### Restore from Backup

```bash
#!/bin/bash
# restore-vm.sh

VM_NAME="windows11"
BACKUP_DIR="/backup/vms/20250101"
VM_IMAGE_DIR="/var/lib/libvirt/images"
NVRAM_DIR="/var/lib/libvirt/qemu/nvram"

# Undefine existing VM if present
virsh destroy $VM_NAME 2>/dev/null
virsh undefine $VM_NAME --nvram 2>/dev/null

# Restore disk image
echo "Restoring disk image..."
cp -v "$BACKUP_DIR/${VM_NAME}.qcow2" "$VM_IMAGE_DIR/"

# Restore NVRAM if exists
if [ -f "$BACKUP_DIR/${VM_NAME}_VARS.fd" ]; then
    echo "Restoring NVRAM..."
    cp -v "$BACKUP_DIR/${VM_NAME}_VARS.fd" "$NVRAM_DIR/"
fi

# Define VM from XML
echo "Defining VM from XML..."
virsh define "$BACKUP_DIR/${VM_NAME}.xml"

# Start VM
echo "Starting VM..."
virsh start $VM_NAME

echo "Restore complete!"
```

### Restore from Compressed Backup

```bash
#!/bin/bash
# restore-compressed.sh

BACKUP_FILE="/backup/vms/windows11-20250101.tar.gz"
VM_NAME="windows11"
RESTORE_DIR="/var/lib/libvirt/images"

# Extract backup
echo "Extracting backup..."
tar xzf "$BACKUP_FILE" -C "$RESTORE_DIR"

# Restore XML
zcat "${BACKUP_FILE}.xml.gz" > /tmp/${VM_NAME}.xml

# Define and start VM
virsh define /tmp/${VM_NAME}.xml
virsh start $VM_NAME

rm /tmp/${VM_NAME}.xml
```

## Automated Backup Scripts

### Daily Backup with Rotation

```bash
#!/bin/bash
# daily-backup.sh

VM_NAME="windows11"
BACKUP_BASE="/backup/vms"
KEEP_DAYS=7

# Create today's backup
BACKUP_DIR="$BACKUP_BASE/$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

# Backup VM
virsh shutdown $VM_NAME
while virsh list | grep -q "$VM_NAME.*running"; do sleep 5; done

cp /var/lib/libvirt/images/${VM_NAME}.qcow2 "$BACKUP_DIR/"
virsh dumpxml $VM_NAME > "$BACKUP_DIR/${VM_NAME}.xml"

virsh start $VM_NAME

# Delete old backups
find "$BACKUP_BASE" -maxdepth 1 -type d -mtime +$KEEP_DAYS -exec rm -rf {} \;

echo "Backup complete. Keeping last $KEEP_DAYS days."
```

### Cron Job Setup

```bash
# Edit crontab
crontab -e

# Add daily backup at 2 AM
0 2 * * * /usr/local/bin/daily-backup.sh >> /var/log/vm-backup.log 2>&1

# Add weekly full backup on Sunday at 3 AM
0 3 * * 0 /usr/local/bin/weekly-full-backup.sh >> /var/log/vm-backup.log 2>&1
```

## Remote Backups

### Backup to Remote Server

```bash
#!/bin/bash
# remote-backup.sh

VM_NAME="windows11"
REMOTE_SERVER="backup-server.example.com"
REMOTE_USER="backupuser"
REMOTE_PATH="/backups/vms"

# Create local backup
LOCAL_BACKUP="/tmp/${VM_NAME}-$(date +%Y%m%d).tar.gz"

virsh shutdown $VM_NAME
while virsh list | grep -q "$VM_NAME.*running"; do sleep 5; done

tar czf "$LOCAL_BACKUP" \
    -C /var/lib/libvirt/images "${VM_NAME}.qcow2"

virsh start $VM_NAME

# Transfer to remote server
echo "Transferring to remote server..."
rsync -avz --progress "$LOCAL_BACKUP" \
    "${REMOTE_USER}@${REMOTE_SERVER}:${REMOTE_PATH}/"

# Cleanup local backup
rm "$LOCAL_BACKUP"

echo "Remote backup complete"
```

### Backup to Cloud Storage (S3)

```bash
#!/bin/bash
# backup-to-s3.sh

VM_NAME="windows11"
S3_BUCKET="s3://my-vm-backups"
LOCAL_BACKUP="/tmp/${VM_NAME}-$(date +%Y%m%d).tar.gz"

# Install aws-cli if not present
# dnf install awscli

# Create backup
virsh shutdown $VM_NAME
while virsh list | grep -q "$VM_NAME.*running"; do sleep 5; done

tar czf "$LOCAL_BACKUP" \
    -C /var/lib/libvirt/images "${VM_NAME}.qcow2"

virsh start $VM_NAME

# Upload to S3
aws s3 cp "$LOCAL_BACKUP" "$S3_BUCKET/" \
    --storage-class STANDARD_IA

# Cleanup
rm "$LOCAL_BACKUP"

echo "S3 backup complete"
```

## Disaster Recovery

### Create Recovery ISO

Include recovery scripts on bootable media:

```bash
# Create recovery directory
mkdir -p /tmp/recovery
cp /backup/vms/latest/* /tmp/recovery/
cp restore-vm.sh /tmp/recovery/

# Create ISO
genisoimage -o /backup/recovery.iso \
    -V "VM_RECOVERY" \
    -R -J /tmp/recovery/
```

### Document Recovery Procedure

Create `/backup/RECOVERY.md`:

```markdown
# VM Recovery Procedure

## Prerequisites
- Fedora 43 with KVM installed
- Access to backup files
- Root/sudo access

## Steps
1. Install KVM: `sudo ./install-kvm.sh`
2. Restore VM: `sudo ./restore-vm.sh`
3. Start VM: `virsh start windows11`
4. Verify: Connect with virt-manager

## Backup Locations
- Primary: /backup/vms/
- Remote: backup-server:/backups/vms/
- Cloud: s3://my-vm-backups/

## Support Contacts
- Admin: admin@example.com
- Phone: +1-555-0100
```

## Monitoring Backup Status

### Backup Verification Script

```bash
#!/bin/bash
# verify-backup.sh

BACKUP_DIR="/backup/vms/latest"
VM_NAME="windows11"

echo "Verifying backup in $BACKUP_DIR"

# Check if backup exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "ERROR: Backup directory not found"
    exit 1
fi

# Check disk image
if [ -f "$BACKUP_DIR/${VM_NAME}.qcow2" ]; then
    echo "✓ Disk image found"
    qemu-img check "$BACKUP_DIR/${VM_NAME}.qcow2"
else
    echo "✗ Disk image missing"
    exit 1
fi

# Check XML
if [ -f "$BACKUP_DIR/${VM_NAME}.xml" ]; then
    echo "✓ XML definition found"
else
    echo "✗ XML definition missing"
    exit 1
fi

echo "Backup verification complete"
```

## Best Practices

1. **Test Restores Regularly**: Verify backups can be restored
2. **Multiple Backup Locations**: Local + remote + cloud
3. **Automate Backups**: Use cron for scheduled backups
4. **Monitor Backup Jobs**: Set up alerts for failures
5. **Document Procedures**: Keep recovery documentation updated
6. **Use Snapshots for Quick Recovery**: Before major changes
7. **Keep Multiple Versions**: Don't overwrite previous backups immediately
8. **Verify Backup Integrity**: Check disk images with `qemu-img check`

## Additional Tools

- **Bacula**: Enterprise backup solution
- **Borg Backup**: Deduplicating backup program
- **Restic**: Fast, secure backup program
- **Duplicity**: Encrypted bandwidth-efficient backup

## Resources

- [libvirt Snapshots](https://wiki.libvirt.org/page/Snapshots)
- [QEMU Image Tools](https://qemu.readthedocs.io/en/latest/tools/qemu-img.html)
- [virtnbdbackup](https://github.com/abbbi/virtnbdbackup)
