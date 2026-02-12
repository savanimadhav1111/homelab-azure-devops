# Day 4

**Focus:** Linux networking + firewall

## Tasks
- [x] Review IPs/CIDR/DNS basics
- [x] Create firewall rules
- [x] Test ports

## Evidence to Capture
- [x] Firewall rules table
- [x] Port test output

## Step-by-Step (Commands)
Run from PowerShell.

### 1) Review network basics on Linux VM
```powershell
$ip=(az vm show -d -g rg-homelab-devops -n vm-day3-ssh-temp --query publicIps -o tsv)
wsl -e bash -lc "ssh -i ~/.ssh/id_ed25519_day3 -o BatchMode=yes azureuser@$ip 'ip -4 addr show; ip route; cat /etc/resolv.conf'"
```

### 2) Baseline port tests (before new rules)
```powershell
Test-NetConnection -ComputerName $ip -Port 22
Test-NetConnection -ComputerName $ip -Port 8080
Test-NetConnection -ComputerName $ip -Port 9090
```

### 3) Create firewall (NSG) rules
```powershell
$myIp=(Invoke-RestMethod -Uri "https://api.ipify.org")
az network nsg rule create -g rg-homelab-devops --nsg-name vm-day3-ssh-tempNSG -n allow-http-8080-myip --priority 1010 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes "$myIp/32" --destination-port-ranges 8080
az network nsg rule create -g rg-homelab-devops --nsg-name vm-day3-ssh-tempNSG -n deny-9090-myip --priority 1020 --direction Inbound --access Deny --protocol Tcp --source-address-prefixes "$myIp/32" --destination-port-ranges 9090
```

### 4) Start a listener and re-test ports
```powershell
wsl -e bash -lc "ssh -i ~/.ssh/id_ed25519_day3 -o BatchMode=yes azureuser@$ip 'nohup python3 -m http.server 8080 --bind 0.0.0.0 >/tmp/day4-http.log 2>&1 &'"
Test-NetConnection -ComputerName $ip -Port 8080
Test-NetConnection -ComputerName $ip -Port 9090
```

### 5) Cost control
```powershell
az vm deallocate -g rg-homelab-devops -n vm-day3-ssh-temp
```

## Day Log
- Date: 2026-02-12
- What I built:
  - Reviewed VM network identity and routing (`10.0.0.4/24`, default route via `10.0.0.1`).
  - Reviewed DNS resolver config on Linux (`127.0.0.53` stub resolver).
  - Added NSG inbound rules for controlled access tests:
    - `allow-http-8080-myip` (Allow TCP/8080 from my public IP `/32`)
    - `deny-9090-myip` (Deny TCP/9090 from my public IP `/32`)
  - Validated port behavior with `Test-NetConnection`.
  - Deallocated VM after tests for cost control.
- What I learned:
  - CIDR controls source scope directly in NSG rules (`x.x.x.x/32` for single-host access).
  - Port validation should include both service listener state and cloud firewall policy.
- Issues/risks:
  - B-series capacity limitations in `Canada Central` continue to affect low-cost testing.
  - Deallocated VM still keeps disk/NIC/public IP resources; review cleanup later.
- Next steps:
  - Day 5: Linux storage (`lsblk`, filesystems, mount/fstab`) and document commands/outcomes.

## Links
- `docs/networking-firewall-notes.md`
