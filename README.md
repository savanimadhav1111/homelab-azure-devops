# homelab-azure-devops
Azure-first DevOps homelab building a production-style platform on a VM using Terraform, Ansible, Docker, and k3s. Implements GitOps with Argo CD, CI/CD via GitHub Actions, and observability with Prometheus, Grafana, and Loki. Demonstrates secure, automated, and cost-optimized cloud infrastructure.

## Day 1 Log (2026-02-08)
**Focus:** Toolchain setup, cloud access, and cost guardrails.

**What I completed**
- Installed core tooling on Windows: Azure CLI, Terraform, kubectl, Helm, Git.
- Installed Ansible in WSL (Ubuntu) to use a Linux-native automation environment.
- Logged into Azure and confirmed active subscription for Canada Central.
- Created a $50/month budget alert for cost control.
- Established repository structure for ongoing documentation.

**Why it matters (DevOps rationale)**
- Toolchain consistency is required for repeatable IaC, CI/CD, and cluster operations.
- WSL-based Ansible keeps automation aligned with Linux-based production environments.
- Budget guardrails are standard practice for cloud cost governance.

**Notes / blockers**
- None. All core tools validated and ready for Terraform scaffolding.

**Next step (Day 2)**
- Validate Azure fundamentals (resource group, VNet, NSG) and document the architecture baseline.

## Day 2 (In Progress)
- Checklist: `docs/daily/day02.md`
- Concepts summary: `docs/azure-concepts-summary.md`

**Status (2026-02-11)**
- Confirmed default subscription and Canada Central region via Azure CLI.
- Verified $50/month budget exists (`homelab-50`).
- Created resource group `rg-homelab-devops` in `canadacentral`.

## Day 3 (Completed - 2026-02-12)
- Checklist: `docs/daily/day03.md`
- Notes: `docs/linux-ssh-notes.md`
- Practiced key-based SSH to temporary Ubuntu VM (`vm-day3-ssh-temp`) and deallocated it after validation.

## Day 4 (Completed - 2026-02-12)
- Checklist: `docs/daily/day04.md`
- Notes: `docs/networking-firewall-notes.md`
- Validated networking basics (IP/CIDR/DNS), added NSG firewall rules, and verified port behavior (`22`/`8080`/`9090`).

## Day 5 (Completed - 2026-02-12)
- Checklist: `docs/daily/day05.md`
- Notes: `docs/storage-notes.md`
- Attached a data disk, formatted it with `ext4`, mounted to `/data/day5`, and persisted via `fstab` UUID entry.

## Day 6 (Completed - 2026-02-12)
- Checklist: `docs/daily/day06.md`
- Notes: `docs/bash-scripting-notes.md`
- Added and executed a Bash package bootstrap script with error handling, loops, and package-manager detection.

## Day 7 (Completed - 2026-02-19)
- Checklist: `docs/daily/day07.md`
- Week 1 summary: `docs/weekly/week1-summary.md`
- Published weekly review with 3 key learnings and one process improvement for next week.

## Day 8 (Completed - 2026-02-19)
- Checklist: `docs/daily/day08.md`
- Notes: `docs/terraform-day8-notes.md`
- Built Terraform foundation and applied first Terraform-managed Azure resource group.
