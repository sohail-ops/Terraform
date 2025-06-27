resource "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.subnets : subnet.subnet_name => subnet }

  name                 = each.value.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value.address_prefixes
}
