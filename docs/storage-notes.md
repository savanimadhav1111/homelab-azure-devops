# Linux Storage Notes (Day 5)

Date: 2026-02-12
VM: `vm-day3-ssh-temp`
Disk: `day5-data-disk-01` (4 GiB, `Standard_LRS`)

## Storage Concepts
- `ext4`: default Linux filesystem, journaling, stable for general workloads.
- `/etc/fstab`: persistent mount configuration loaded at boot.
- UUID mount: stable identifier for block devices across reboots.
- Permissions:
  - `chown user:group <path>` controls ownership.
  - `chmod 750 <path>` gives rwx to owner, rx to group, no access to others.

## Commands Used

```bash
lsblk -f
/sbin/mkfs.ext4 -F /dev/sdb1
UUID=$(/sbin/blkid -s UUID -o value /dev/sdb1)
mkdir -p /data/day5
echo "UUID=$UUID /data/day5 ext4 defaults,nofail 0 2" >> /etc/fstab
mount -a
df -hT /data/day5
stat -c "%A %U:%G %n" /data/day5
```

## Evidence
- Filesystem UUID: `315392b7-d35d-49eb-a8bb-425c98163820`
- `lsblk -f` shows:
  - `sdb1 ext4 ... /data/day5`
- `fstab` entry:
  - `UUID=315392b7-d35d-49eb-a8bb-425c98163820 /data/day5 ext4 defaults,nofail 0 2`
- `df -hT /data/day5`:
  - Type `ext4`, size `3.9G`, mounted at `/data/day5`
- Permissions:
  - `drwxr-x--- azureuser:azureuser /data/day5`

## Cost Note
- VM is deallocated after testing.
- Managed disk remains attached and billable (storage only).
