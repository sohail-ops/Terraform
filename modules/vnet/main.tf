resource "azurerm_virtual_network" "vnet" {
  for_each            = { for vnet in var.vnets : vnet.vnet_name => vnet }

  name                = each.value.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = var.tags
}