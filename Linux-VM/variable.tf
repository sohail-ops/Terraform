variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "example-rg"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "West US 2"
}

variable "pip_name" {
  description = "Name of the Public IP"
  type        = string
  default     = "example-pip"
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "example-nsg"
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
  default     = "example-vm"
}

variable "admin_username" {
  description = "Admin Username for VM"
  type        = string
  default     = "azadmin"
}

variable "admin_password" {
  description = "Admin Password for VM"
  type        = string
  sensitive   = true
  default     = "Complicated@321"
}
