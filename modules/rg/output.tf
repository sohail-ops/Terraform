output "rg_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.rg.id
}

output "rg_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "rg_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "tags" {
  description = "The tags of the resource group"
  value       = azurerm_resource_group.rg.tags
}