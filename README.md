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
