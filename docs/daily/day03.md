# Day 3

**Focus:** Linux fundamentals + SSH

## Tasks
- [x] Review users/groups/sudo
- [x] Generate SSH keys if not already
- [x] Practice SSH into a Linux target

## Evidence to Capture
- [x] Commands used + outputs
- [x] SSH config snippet

## Step-by-Step (Commands)
Run from PowerShell unless noted.

### 1) Linux user/group/sudo review in WSL
```powershell
wsl -e bash -lc "whoami; id; groups; sudo -n true && echo SUDO_NOPASSWD=YES || echo SUDO_NOPASSWD=NO"
```

### 2) Verify SSH client and existing keys
```powershell
ssh -V
Test-Path "$env:USERPROFILE\.ssh\id_ed25519.pub"
```

### 3) Generate Day 3 lab key in WSL
```powershell
wsl -e bash -lc "ssh-keygen -t ed25519 -C 'day3-homelab' -f ~/.ssh/id_ed25519_day3 -N ''"
```

### 4) SSH into a temporary Linux VM in Azure
```powershell
# VM created in rg-homelab-devops: vm-day3-ssh-temp
$ip = (az vm show -d -g rg-homelab-devops -n vm-day3-ssh-temp --query publicIps -o tsv)
wsl -e bash -lc "ssh -i ~/.ssh/id_ed25519_day3 -o BatchMode=yes -o StrictHostKeyChecking=accept-new azureuser@$ip 'whoami; id; groups'"
```

### 5) Cost control after practice
```powershell
az vm deallocate -g rg-homelab-devops -n vm-day3-ssh-temp
```

## Day Log
- Date: 2026-02-12
- What I built:
  - Reviewed Linux identity and privilege context in WSL (`whoami`, `id`, `groups`, `sudo` check).
  - Generated Day 3 SSH keypair (`~/.ssh/id_ed25519_day3`) in WSL.
  - Practiced key-based SSH login to temporary Ubuntu VM `vm-day3-ssh-temp`.
  - Deallocated VM after validation to reduce cost.
- What I learned:
  - SSH client auth can fail in non-interactive mode when a key is passphrase-protected and no agent is running.
  - `id` + `groups` + `sudo -l` quickly validate Linux access posture.
- Issues/risks:
  - B-series VM SKUs were capacity-restricted in `Canada Central`; fallback to `Standard_D2s_v5` was required.
  - Temporary VM remains provisioned (deallocated); still incurs storage/network costs.
- Next steps:
  - Day 4 networking: IP/CIDR/DNS and NSG/firewall rule testing.

## Links
- `docs/linux-ssh-notes.md`
