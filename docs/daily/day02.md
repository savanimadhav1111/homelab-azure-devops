# Day 2

**Focus:** Azure basics + budget verification

## Tasks
- [x] Confirm subscription and region (Canada Central)
- [x] Verify budget alerts are active
- [x] Write 1-page Azure concepts summary (VNet, NSG, VM)
- [x] Create resource group in Canada Central (`rg-homelab-devops`)

## Evidence to Capture
- [ ] Screenshot: Cost Management budget
- [ ] Notes: Azure core concepts summary

## Step-by-Step (Commands)
Run these from PowerShell.

### 1) Confirm subscription (and set default if needed)
```powershell
az account show -o table
az account list -o table
```

If your intended subscription is not the default:
```powershell
# Replace with the subscription ID or name you want to use.
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
az account show -o table
```

### 2) Confirm region (Canada Central) is available and spelled correctly
```powershell
az account list-locations -o table | Select-String -Pattern "Canada Central|canadacentral"
```

### 3) Verify the $50 budget alert exists
Portal path: `Azure Portal -> Cost Management + Billing -> Budgets`

CLI:
```powershell
az consumption budget list -o table
```

### 4) (Optional) Create a placeholder resource group in Canada Central
Only do this if you want Day 2 to include an actual Azure artifact.
```powershell
az group create -n "rg-homelab-devops" -l "canadacentral" -o table
```

## Day Log (Fill In)
- Date: 2026-02-11
- What I built:
  - Confirmed default subscription: `Azure subscription 1` (`2fbdaf77-3ee8-4e6d-89b8-e38bb1cbbe4e`)
  - Verified region exists: `Canada Central` (`canadacentral`)
  - Verified budget exists: `homelab-50` ($50/month)
  - Created resource group: `rg-homelab-devops` in `canadacentral`
- What I learned:
  - How to verify subscription/region from CLI and where budgets live in the portal.
- Issues/risks:
  - `az consumption budget` shows a preview warning in CLI; portal remains the source of truth.
- Next steps:
  - Day 3: Linux fundamentals + SSH practice (`docs/daily/day03.md`)

## Links
- `docs/azure-concepts-summary.md`
