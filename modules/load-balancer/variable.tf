variable "lb_name" {
  description = "The name of Load Balancer"
  type        = string
}

variable "location" {
  description = "The location of Load Balancer"
  type        = string
}

variable "rg_name" {
  description = "The name of Resource Group"
  type        = string
}

variable "tags" {
  description = "The tags for the Resource Group"
  type        = map(string)
  default     = {}
}

variable "pip_id" {
  description = "The public IP address ID"
  type        = string
}

variable "be_pool_name" {
  description = "The name of backend pool"
  type        = string
}

variable "fe_ipconfig_name" {
  description = "The name of frontend IP configuration"
  type        = string
}

variable "nic_id" {
  description = "The ID of network interface"
  type        = string
}

variable "ip_config_name" {
  description = "The name of Frontend IP configuration"
  type        = string
}

variable "probe_name" {
  description = "The name of health probe"
  type        = string
}

variable "probe_protocol" {
  description = "The protocol for health probe"
  type        = string
  default = "Http"
}

variable "probe_port" {
  description = "The port for health probe"
  type        = number
  default     = 80
}

variable "probe_path" {
  description = "The request path for health probe"
  type        = string
  default     = "/"
}

variable "lb_rule_name" {
  description = "The name of load balancer rule"
  type        = string
}

variable "lb_rule_protocol" {
  description = "The protocol for load balancer rule"
  type        = string
  default     = "Tcp"
}

variable "rule_fe_port" {
  description = "The frontend port for rule"
  type        = number
  default     = 80
}

variable "rule_be_port" {
  description = "The backend port for rule"
  type        = number
  default     = 80
}

variable "disable_outbound_snat" {
  description = "Disable outbound SNAT"
  type        = bool
  default     = true
}

variable "lb_nat_name" {
  description = "The name of load balancer NAT rule"
  type        = string
  default     = "SSHAccess"
}

variable "nat_fe_port_start" {
  description = "The frontend port for NAT rule"
  type        = number
  default     = 22
}

variable "nat_fe_port_end" {
  description = "The frontend port for NAT rule"
  type        = number
  default     = 22
}

variable "nat_be_port" {
  description = "The backend port for NAT rule"
  type        = number
  default     = 22
}