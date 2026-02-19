# Day 8

**Focus:** Terraform foundations

## Tasks
- [x] Create Terraform folder structure
- [x] Initialize providers
- [x] Document module plan
- [x] Run `terraform plan` and `terraform apply`

## Evidence to Capture
- [x] Repo tree snippet
- [x] terraform init output
- [x] apply output and no-drift plan

## Day Log
- Date: 2026-02-19
- What I built:
  - Created Terraform root config in `infrastructure/terraform`.
  - Added provider/version constraints, variables, resource group resource, and outputs.
  - Executed:
    - `terraform init`
    - `terraform plan`
    - `terraform apply`
    - post-apply `terraform plan` (no changes)
  - Provisioned resource group: `rg-homelab-tf-day8` in `canadacentral`.
- What I learned:
  - Keeping provider/version files separate improves clarity as modules grow.
  - Local state works for quick labs, but module expansion should move to remote backend soon.
- Issues/risks:
  - First `plan` timed out and left a lock file; stale local locks can interrupt workflow.
- Next steps:
  - Day 9: add VNet + subnet in Terraform and update architecture docs.

## Links
- `infrastructure/terraform/main.tf`
- `docs/terraform-module-plan.md`
- `docs/terraform-day8-notes.md`
