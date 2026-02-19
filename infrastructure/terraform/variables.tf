variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Terraform-managed resource group name."
  type        = string
  default     = "rg-homelab-tf-day8"
}

variable "tags" {
  description = "Tags applied to resources."
  type        = map(string)
  default = {
    project = "homelab"
    owner   = "madhav"
    day     = "8"
  }
}
