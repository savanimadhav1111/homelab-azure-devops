# Azure Concepts Summary (VNet, NSG, VM)

This is a 1-page refresher for the core building blocks used in this homelab.

## Resource Group (RG)
- A logical container for related Azure resources (VMs, VNets, public IPs, etc.).
- Use one RG per environment/project so cleanup is easy (`rg-homelab-devops`).

## Region
- Physical location where resources live (this lab uses `Canada Central` / `canadacentral`).
- Keep dependent resources in the same region to avoid latency and cross-region data charges.

## Virtual Network (VNet)
- A private network boundary in Azure, similar to a data-center network.
- A VNet contains one or more subnets and defines an address space (CIDR), e.g. `10.10.0.0/16`.

## Subnet
- A slice of the VNet address space, e.g. `10.10.1.0/24`.
- Subnets are where VMs (via NICs) are attached.

## Network Security Group (NSG)
- Layer-4 (TCP/UDP) allow/deny rules applied to subnets and/or NICs.
- Typical baseline:
  - Allow `SSH` (TCP/22) only from your current public IP (not `0.0.0.0/0`).
  - Deny everything else inbound by default (Azure NSG has default rules; your custom rules should be explicit).
- Think of NSG as your cloud firewall policy for north-south traffic to the VM and east-west traffic between subnets.

## Public IP
- A routable IPv4 address used to reach a VM from the internet.
- Cost and behavior depend on SKU (Basic vs Standard) and allocation method.
- Best practice for SSH:
  - Restrict inbound with NSG.
  - Consider using a jump box or Azure Bastion later (cost tradeoff).

## Network Interface (NIC)
- The “network card” for a VM.
- Attaches to a subnet and can be associated with:
  - a private IP (always),
  - a public IP (optional),
  - an NSG (optional, if not attached at subnet level).

## Virtual Machine (VM)
- A compute instance (CPU/RAM/disk) running an OS (CentOS for this lab).
- Core pieces you’ll create with IaC (Terraform) later:
  - VM, NIC, public IP, NSG, VNet/subnet, OS disk.
- Operational best practices:
  - SSH keys only (disable password auth).
  - Patch regularly.
  - Stop/deallocate when not in use to control spend.

## How Traffic Flows (Mental Model)
1. You connect from your laptop -> VM public IP on TCP/22.
2. The NSG rule must allow your source IP and port.
3. The NIC delivers traffic to the VM on its private IP in the subnet.
4. Outbound traffic from the VM goes through Azure’s default routing unless you add custom routes/NAT.

