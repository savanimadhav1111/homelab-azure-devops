# Terraform Day 8 Notes

Date: 2026-02-19

## Repo Tree Snippet
```text
infrastructure/terraform/
  main.tf
  outputs.tf
  providers.tf
  terraform.tfvars
  variables.tf
  versions.tf
```

## Commands Run
```powershell
terraform init -input=false
terraform plan -input=false -out=tfplan
terraform apply -input=false -auto-approve tfplan
terraform output -no-color
terraform plan -input=false -no-color
```

## Key Output (init)
- Initialized provider plugins successfully.
- Installed `hashicorp/azurerm v4.60.0`.
- Generated `.terraform.lock.hcl`.

## Key Output (apply)
- `Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`
- Outputs:
  - `resource_group_name = "rg-homelab-tf-day8"`
  - `resource_group_location = "canadacentral"`

## Post-Apply Validation
- `terraform plan` returned:
  - `No changes. Your infrastructure matches the configuration.`
- Azure validation:
  - Resource group `rg-homelab-tf-day8` exists in `canadacentral`.
  - Tags: `project=homelab`, `owner=madhav`, `day=8`.
