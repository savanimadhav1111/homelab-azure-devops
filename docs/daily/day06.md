# Day 6

**Focus:** Bash scripting

## Tasks
- [x] Write a package install script
- [x] Add error handling (set -e, traps)
- [x] Run script and capture output

## Evidence to Capture
- [x] Script file
- [x] Execution output

## Step-by-Step (Commands)
Run from PowerShell.

### 1) Copy script to VM
```powershell
$ip=(az vm show -d -g rg-homelab-devops -n vm-day3-ssh-temp --query publicIps -o tsv)
wsl -e bash -lc "scp -i ~/.ssh/id_ed25519_day3 /mnt/c/Users/Madhav/Desktop/Homelab/homelab-azure-devops/scripts/install-common-packages.sh azureuser@${ip}:/tmp/install-common-packages.sh"
```

### 2) Execute script and verify tools
```powershell
wsl -e bash -lc "ssh -i ~/.ssh/id_ed25519_day3 azureuser@${ip} 'chmod +x /tmp/install-common-packages.sh && sudo /tmp/install-common-packages.sh && git --version && curl --version | head -n 1 && jq --version && unzip -v | head -n 1'"
```

### 3) Cost control
```powershell
az vm deallocate -g rg-homelab-devops -n vm-day3-ssh-temp
```

## Day Log
- Date: 2026-02-12
- What I built:
  - Added reusable Bash automation script: `scripts/install-common-packages.sh`
  - Script includes:
    - strict mode: `set -Eeuo pipefail`
    - error trap with line/command reporting
    - variable-based package list (default + optional args)
    - package manager detection (`apt`, `dnf`, `yum`)
    - looped install flow with skip/install summary
  - Executed script on VM and validated package versions.
- What I learned:
  - A small Bash wrapper can be cross-distro if package-manager detection is centralized.
  - Loop + helper functions keep scripts maintainable and easy to extend.
- Issues/risks:
  - Non-interactive SSH sessions can print `debconf` frontend warnings during `apt` operations.
  - VM was deallocated after testing; reruns require VM start first.
- Next steps:
  - Day 7 weekly review with summary bullets and screenshot evidence.

## Links
- `scripts/install-common-packages.sh`
- `docs/bash-scripting-notes.md`
