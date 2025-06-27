output "vnet_ids" {
  description = "A map of virtual network names to their IDs."
  value       = { for vnet in azurerm_virtual_network.vnet : vnet.name => vnet.id }
}

output "vnet_names" {
  description = "A list of virtual network names."
  value       = [for vnet in azurerm_virtual_network.vnet : vnet.name]
}

output "vnet_locations" {
  description = "A map of virtual network names to their locations."
  value       = { for vnet in azurerm_virtual_network.vnet : vnet.name => vnet.location }
}
