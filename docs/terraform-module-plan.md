# Terraform Module Plan (Day 8)

Date: 2026-02-19

## Current Scope (Implemented)
- Root Terraform config to create:
  - `azurerm_resource_group.foundation`

## Planned Module Split (Week 2)
- `modules/resource-group`
  - inputs: name, location, tags
  - output: resource_group_name
- `modules/network`
  - resources: vnet, subnet
  - output: subnet_id, vnet_name
- `modules/security`
  - resources: nsg + rules
  - output: nsg_id
- `modules/compute`
  - resources: public ip, nic, linux vm, optional data disk
  - output: vm_name, public_ip

## Target Environment Layout
- `infrastructure/terraform/envs/dev`
- `infrastructure/terraform/modules/*`

## State Approach
- Short term: local state for lab speed.
- Next step: migrate to remote state backend in Azure Storage Account.
