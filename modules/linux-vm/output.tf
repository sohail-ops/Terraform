output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_public_ip" {
  description = "The public IP of the VM"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "The name of the network security group"
  value       = azurerm_network_security_group.nsg.name
}

output "nic_id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.id
}

output "nic_ipconfig_name" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.ip_configuration[0].name
}

output "ssh_private_key" {
  description = "The SSH private key"
  value     = length(azapi_resource_action.ssh_public_key_gen) > 0 ? azapi_resource_action.ssh_public_key_gen[0].output.privateKey : null
  sensitive = true
}

output "ssh_public_key" {
  description = "The SSH public key"
  value     = length(azapi_resource_action.ssh_public_key_gen) > 0 ? azapi_resource_action.ssh_public_key_gen[0].output.publicKey : null
  sensitive = true
}