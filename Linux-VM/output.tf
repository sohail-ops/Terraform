output "vm_pip" {
  description = "The public IP address of Load Balancer"
  value       = module.vm_pip.pip_address
}