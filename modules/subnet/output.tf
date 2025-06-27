output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}

output "subnet_names" {
  description = "A list of subnet names."
  value       = [for subnet in azurerm_subnet.subnet : subnet.name]
}

output "subnet_address_prefixes" {
  description = "A map of subnet names to their address prefixes."
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.address_prefixes }
}