# Day 5

**Focus:** Linux storage

## Tasks
- [x] Review ext4/fstab/permissions
- [x] Mount a disk/partition
- [x] Document storage commands

## Evidence to Capture
- [x] fstab entry
- [x] mount/df output

## Step-by-Step (Commands)
Run from PowerShell.

### 1) Attach a managed disk to the VM
```powershell
az disk create -g rg-homelab-devops -n day5-data-disk-01 --size-gb 4 --sku Standard_LRS
az vm disk attach -g rg-homelab-devops --vm-name vm-day3-ssh-temp --name day5-data-disk-01 --lun 1
```

### 2) Partition, format, mount, and persist
Used Run Command on the VM:

```bash
/sbin/mkfs.ext4 -F /dev/sdb1
UUID=$(/sbin/blkid -s UUID -o value /dev/sdb1)
mkdir -p /data/day5
echo "UUID=$UUID /data/day5 ext4 defaults,nofail 0 2" >> /etc/fstab
mount -a
chown azureuser:azureuser /data/day5
chmod 750 /data/day5
```

### 3) Verify
```bash
lsblk -f
grep /data/day5 /etc/fstab
df -hT /data/day5
stat -c "%A %U:%G %n" /data/day5
```

## Day Log
- Date: 2026-02-12
- What I built:
  - Created and attached `day5-data-disk-01` (4 GiB) to `vm-day3-ssh-temp` at `LUN 1`.
  - Formatted `/dev/sdb1` as `ext4`.
  - Mounted disk to `/data/day5`.
  - Added persistent `fstab` entry using UUID.
  - Applied mount-point ownership and permissions (`azureuser:azureuser`, `750`).
- What I learned:
  - UUID-based `fstab` entries are safer than raw device names for boot-time mounts.
  - `nofail` in `fstab` avoids boot interruption if a non-root data disk is unavailable.
- Issues/risks:
  - VM remains deallocated for cost control, but attached disk still incurs storage cost.
  - Day 5 uses imperative CLI steps; Terraform-based disk management comes later in IaC week.
- Next steps:
  - Day 6: Bash scripting basics and package-install automation script.

## Links
- `docs/storage-notes.md`
