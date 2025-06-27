variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Virtual Machine"
  type        = string
}

variable "pip_name" {
  description = "The name of the Public IP"
  type        = string
  
}

variable "allocation_method" {
  description = "The allocation method of the Public IP"
  type        = string
  default     = "Dynamic"
}

variable "sku" {
  description = "The SKU of the Public IP"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "The tags for the Resource Group"
  type        = map(string)
  default     = {}
}