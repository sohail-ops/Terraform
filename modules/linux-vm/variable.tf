variable "rg_id" {
  description = "The ID of the Resource Group"
  type        = string
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Virtual Machine"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the VM will be placed"
  type        = string
}

variable "pip_id" {
  description = "Public-IP ID to associate with the VM"
  type        = string
  default = null
}

variable "vm_sku" {
  description = "The sku of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Admin Username"
  type        = string
  default = "azadmin"
}

variable "admin_password" {
  description = "Admin Password"
  sensitive   = true
  type        = string
}

variable "create_ssh_with_password" {
  description = "A flag to control whether an SSH key should be generated even when password authentication is enabled."
  type        = bool
  default     = false
}

variable "disable_pass_auth" {
  description = "Disable password authentication"
  type        = bool
  default     = false
}

variable "ssh_public_key" {
  description = "Public SSH key"
  type        = string
  default     = null
}

variable "stoacc_type" {
  description = "The storage account type for the OS disk"
  type        = string
  default = "StandardSSD_LRS"         //or Standard_LRS or Premium_LRS
}

variable "disk_size_gb" {
  description = "The disk size in GB"
  type        = number
  default = 32
}

variable "image_publisher" {
  description = "The image publisher"
  type        = string
  default = "Canonical"
}

variable "image_offer" {
  description = "The image offer"
  type        = string
  default = "ubuntu-24_04-lts"
}

variable "image_sku" {
  description = "The image SKU"
  type        = string
  default = "server"
}

variable "image_version" {
  description = "The image version"
  type        = string
  default = "latest"
}

variable "tags" {
  description = "The tags for the Resource Group"
  type        = map(string)
  default     = {}
}

variable "custom_data" {
  description = "Custom Data for the VM"
  type        = string
  default     = null
}