variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "subnets" {
  description = "A list of subnet objects, each containing subnet_name and address_prefixes."
  type = list(object({
    subnet_name     = string
    address_prefixes = list(string)
  }))
  default = []
}