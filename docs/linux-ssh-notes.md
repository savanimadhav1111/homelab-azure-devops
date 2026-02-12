# Linux Fundamentals + SSH Notes

Date: 2026-02-12

## Linux Identity Commands
- `whoami`: current effective username.
- `id`: UID, GID, and group memberships.
- `groups`: quick list of supplementary groups.
- `sudo -l`: what commands the user can run with sudo.

## Evidence Collected
WSL output showed:
- User: `madhav`
- Groups include: `sudo`, `adm`, `users`
- `sudo -n true` returned `SUDO_NOPASSWD=NO` (password required for sudo)

Remote Ubuntu VM output showed:
- User: `azureuser`
- Groups include: `sudo`, `adm`, `netdev`, `lxd`
- `sudo -l` confirms `azureuser` can run all commands with sudo

## SSH Key Workflow Used
1. Verified SSH client:
   - `ssh -V` -> `OpenSSH_for_Windows_9.5p2`
2. Existing key check:
   - Existing Windows key was present but passphrase-protected.
3. Generated dedicated lab key in WSL:
   - `ssh-keygen -t ed25519 -C 'day3-homelab' -f ~/.ssh/id_ed25519_day3 -N ''`
4. Added public key to temporary VM user and validated login.

## SSH Config Snippet (Recommended)
Use this in `~/.ssh/config` (WSL or Windows path equivalent):

```sshconfig
Host day3-temp-vm
  HostName 20.48.248.158
  User azureuser
  IdentityFile ~/.ssh/id_ed25519_day3
  IdentitiesOnly yes
  StrictHostKeyChecking accept-new
```

Connect with:
```bash
ssh day3-temp-vm
```

## Cost Note
- Temporary VM: `vm-day3-ssh-temp` in `rg-homelab-devops`
- VM was deallocated after SSH validation to reduce compute cost.
