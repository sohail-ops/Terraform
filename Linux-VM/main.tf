# Resource Group
module "rg" {
  source   = "../modules/rg"
  rg_name  = var.rg_name
  location = var.location
  tags     = { "Environment" = "Dev" }
}

# Virtual Network
module "vnet" {
  source   = "../modules/vnet"
  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.tags
  vnets = [
    {
      vnet_name     = "i2d-vnet"
      address_space = ["10.10.0.0/16"]
      dns_servers   = []
  }]
  depends_on = [module.rg]
}

# Subnets
module "subnet" {
  source    = "../modules/subnet"
  rg_name   = module.rg.rg_name
  vnet_name = module.vnet.vnet_names[0]
  subnets = [
    {
      subnet_name      = "public-subnet"
      address_prefixes = ["10.10.1.0/24"]
    },
    {
      subnet_name      = "private-subnet"
      address_prefixes = ["10.10.2.0/24"]
  }]
  depends_on = [module.vnet]
}

# Public IP Address
module "vm_pip" {
  source            = "../modules/public-ip"
  pip_name          = "${var.vm_name}-pip"
  location          = module.rg.rg_location
  rg_name           = module.rg.rg_name
  allocation_method = "Static"
  sku               = "Standard"
  tags              = module.rg.tags
  depends_on        = [module.rg]
}

# Linux Virtual Machine
module "linux_vm" {
  source                   = "../modules/linux-vm"
  vm_name                  = var.vm_name
  rg_name                  = module.rg.rg_name
  rg_id                    = module.rg.rg_id
  location                 = module.rg.rg_location
  subnet_id                = module.subnet.subnet_ids["private-subnet"]
  pip_id                   = module.vm_pip.pip_id
  tags                     = module.rg.tags
  vm_sku                   = "Standard_D2as_v5"
  admin_username           = var.admin_username
  admin_password           = var.admin_password
  disable_pass_auth        = false
  create_ssh_with_password = false

  # custom_data = base64encode(<<-EOF
  #             #!/bin/bash
  #             sudo apt update -y && sudo apt upgrade -y
  #             sudo apt install gnupg2 software-properties-common -y
  #             sudo apt-add-repository ppa:ansible/ansible
  #             sudo apt update -y && sudo apt install ansible -y
  #             EOF
  # )
  depends_on = [module.rg, module.subnet]
}

# Network Security Group Rules.
module "nsg_security_rule" {
  source   = "../modules/nsg_security_rule"
  rg_name  = module.rg.rg_name
  nsg_name = module.linux_vm.nsg_name

  rules = concat(
    module.nsg_security_rule.default_rules, # Default rules from the module output
    [
      {
        name                       = "Allow-HTTPS-IB"
        priority                   = 130
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
  ])
  depends_on = [module.rg, module.linux_vm]
}