output "nsg_rule_ids" {
  value = [for rule in azurerm_network_security_rule.nsg_rule : rule.id]
}

output "default_rules" {
  value = [
    {
      name                     = "Allow-SSH-IB"
      priority                 = 100
      direction                = "Inbound"
      access                   = "Allow"
      protocol                 = "Tcp"
      source_port_range        = "*"
      destination_port_range   = "22"
      source_address_prefix    = "*"
      destination_address_prefix = "*"
    },
    {
      name                     = "Allow-HTTP-IB"
      priority                 = 110
      direction                = "Inbound"
      access                   = "Allow"
      protocol                 = "Tcp"
      source_port_range        = "*"
      destination_port_range   = "80"
      source_address_prefix    = "*"
      destination_address_prefix = "*"
    }
  ]
}