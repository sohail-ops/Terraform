output "lb_id" {
  description = "The ID of load balancer"
  value       = azurerm_lb.lb.id
}

output "frontend_ip" {
  description = "The ID of frontend IP of load balancer"
  value       = azurerm_lb.lb.frontend_ip_configuration[0].public_ip_address_id
}

output "backend_pool_id" {
  description = "The ID of backend pool"
  value       = azurerm_lb_backend_address_pool.lbbe-pool.id
}

output "nat_rule_id" {
  description = "The ID of NAT rule"
  value        = azurerm_lb_nat_rule.lbnat.id
}
