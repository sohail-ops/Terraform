variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "rules" {
  description = "List of security rules to be created in the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.rules : (
        rule.name != "" &&
        rule.priority >= 100 && rule.priority <= 4096 &&
        contains(["Inbound", "Outbound"], rule.direction) &&
        contains(["Allow", "Deny"], rule.access) &&
        contains(["Tcp", "Udp", "*"], rule.protocol)
      )
    ])
    error_message = "Each rule must have a valid name, priority (100-4096), direction (Inbound/Outbound), access (Allow/Deny), and protocol (Tcp/Udp/*)."
  }
}