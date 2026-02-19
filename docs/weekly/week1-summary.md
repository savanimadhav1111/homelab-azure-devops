# Week 1 Summary (Days 1-7)

Date: 2026-02-19

## What Built
- Set up core toolchain (Azure CLI, Terraform, kubectl, Helm, Git, Ansible/WSL).
- Established Azure foundation with budget guardrails and validated region/subscription.
- Practiced Linux administration on a cloud VM:
  - SSH key auth
  - networking and NSG firewall rules
  - storage provisioning (`ext4`, mount, `fstab`)
  - Bash automation script for package bootstrapping

## 3 Key Learnings
- Cloud firewall policy (NSG) and service listeners must both be correct for connectivity.
- UUID-based `fstab` mounts are safer than device-path mounts across reboots.
- Bash scripts become reusable quickly when structured with strict mode, helper functions, and loops.

## 1 Improvement For Next Week
- Shift ad-hoc CLI resource creation into Terraform so infra state is fully reproducible.

## Evidence Checklist
- Screenshot target: Azure Cost Management budget (`homelab-50`).
- Screenshot target: NSG rules table for `vm-day3-ssh-tempNSG`.
- Screenshot target: Day 6 package script execution snippet.
