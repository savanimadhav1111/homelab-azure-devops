# Linux Networking + Firewall Notes

Date: 2026-02-12
Target VM: `vm-day3-ssh-temp` (`rg-homelab-devops`)

## IP/CIDR/DNS Quick Notes
- `10.0.0.4/24` means host IP `10.0.0.4` in subnet `10.0.0.0/24` (mask `255.255.255.0`).
- Default route points to `10.0.0.1` (virtual gateway).
- DNS on Ubuntu VM uses local stub resolver `127.0.0.53` (systemd-resolved).

## Linux Network Evidence
- Interface: `eth0` with `10.0.0.4/24`
- Routes:
  - `default via 10.0.0.1 dev eth0`
  - `10.0.0.0/24 dev eth0`
- DNS: `nameserver 127.0.0.53`

## Firewall Rule Table (Azure NSG)
NSG: `vm-day3-ssh-tempNSG`

| Priority | Rule Name             | Access | Protocol | Source           | Destination Port | Direction |
|---|---|---|---|---|---|---|
| 1000 | default-allow-ssh    | Allow | TCP | `*` | `22` | Inbound |
| 1010 | allow-http-8080-myip | Allow | TCP | `74.12.53.15/32` | `8080` | Inbound |
| 1020 | deny-9090-myip       | Deny  | TCP | `74.12.53.15/32` | `9090` | Inbound |

## Port Test Output Summary

Before adding `8080` allow rule:
- TCP/22: `True`
- TCP/8080: `False`
- TCP/9090: `False`

After adding rules and starting a listener (`python3 -m http.server 8080`):
- TCP/22: `True`
- TCP/8080: `True`
- TCP/9090: `False`

## Operational Notes
- VM was deallocated after testing to control compute cost.
- NSG rules remain in place for repeatable Day 4 evidence.
