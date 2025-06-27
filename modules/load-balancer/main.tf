# Create a load balancer
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = var.fe_ipconfig_name
    public_ip_address_id = var.pip_id
  }
}

# Create a backend address pool
resource "azurerm_lb_backend_address_pool" "lbbe-pool" {
  name            = var.be_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

# Associate the network interface with the backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "nic-bep" {
  network_interface_id    = var.nic_id
  ip_configuration_name   = var.ip_config_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbe-pool.id
}

# Create Load Balancer Health Probe
resource "azurerm_lb_probe" "lb_probe" {
  name            = var.probe_name
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = var.probe_protocol
  port            = var.probe_port
  request_path    = var.probe_protocol == "Http" || var.probe_protocol == "Https" ? var.probe_path : null
}

# Create Load Balancer Rule to forward traffic
resource "azurerm_lb_rule" "lb_rule" {
  name                           = var.lb_rule_name
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lbbe-pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.rule_fe_port
  backend_port                   = var.rule_be_port
  disable_outbound_snat          = var.disable_outbound_snat
}

# Create a load balancer outbound rule
resource "azurerm_lb_outbound_rule" "lb_ob_rule" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.lb.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbe-pool.id
  enable_tcp_reset        = "true"

  frontend_ip_configuration {
    name = azurerm_lb.lb.frontend_ip_configuration[0].name
  }
}

# Create Load Balancer NAT Rule
resource "azurerm_lb_nat_rule" "lbnat" {
  name                           = var.lb_nat_name
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  protocol                       = "Tcp"
  frontend_port_start            = var.nat_fe_port_start
  frontend_port_end              = var.nat_fe_port_end
  backend_port                   = var.nat_be_port
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lbbe-pool.id
}
