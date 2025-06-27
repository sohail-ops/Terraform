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