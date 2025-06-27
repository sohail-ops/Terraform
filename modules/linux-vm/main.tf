terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">=2.2.0"
    }
  }
}

# Create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.pip_id
  }
  accelerated_networking_enabled  = true       # True only with selected SKU's
}

# Associate the network security group with the network interface
resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# SSH Key Pair Generation (Using Azure API)
resource "azapi_resource_action" "ssh_public_key_gen" {
  count                  = var.disable_pass_auth || var.create_ssh_with_password ? 1 : 0
  type                   = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id            = azapi_resource.ssh_public_key[count.index].id
  action                 = "generateKeyPair"
  method                 = "POST"
  response_export_values = ["publicKey", "privateKey"]
}

# SSH Public Key Resource
resource "azapi_resource" "ssh_public_key" {
  count     = var.disable_pass_auth || var.create_ssh_with_password ? 1 : 0
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "${var.vm_name}-ssh-key"
  location  = var.location
  parent_id = var.rg_id
  tags      = var.tags
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.vm_name}-vm"
  location                        = var.location
  resource_group_name             = var.rg_name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  tags                            = var.tags
  size                            = var.vm_sku
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_pass_auth
  # If disable_password_authentication is set to true, the admin_password block will not be created
  admin_password                  = var.disable_pass_auth ? null : var.admin_password

  # Conditionally create the admin_ssh_key block only if:
  # - disable_password_authentication = true
  # - OR disable_password_authentication = false and create_ssh_with_password = true
  dynamic "admin_ssh_key" {
    for_each = var.disable_pass_auth || var.create_ssh_with_password ? [1] : []
    content {
      username   = var.admin_username
      public_key = azapi_resource_action.ssh_public_key_gen[0].output.publicKey
    }
  }

  os_disk {
    name                 = "${var.vm_name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = var.stoacc_type
    disk_size_gb         = var.disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  custom_data = var.custom_data

  boot_diagnostics {}
}

resource "local_file" "private_key_file" {
  count    = azapi_resource_action.ssh_public_key_gen != [] ? 1 : 0
  content  = azapi_resource_action.ssh_public_key_gen[0].output.privateKey
  filename = "${path.module}/ssh-key/private_key.pem"
}

resource "local_file" "public_key_file" {
  count    = azapi_resource_action.ssh_public_key_gen != [] ? 1 : 0
  content  = azapi_resource_action.ssh_public_key_gen[0].output.publicKey
  filename = "${path.module}/ssh-key/public_key.pem"
}