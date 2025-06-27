variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location of the Virtual Network"
  type        = string
}

variable "tags" {
  description = "The tags for the Virtual Network"
  type        = map(string)
  default     = {}
}

variable "vnets" {
  description = "A list of virtual network objects, each containing vnet_name, address_space, and dns_servers."
  type = list(object({
    vnet_name     = string
    address_space = list(string)
    dns_servers   = list(string)
  }))
  default         = []
}