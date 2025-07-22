output "lb_private_ip" {
  value = azurerm_lb.internal.frontend_ip_configuration[0].private_ip_address
  description = "The private IP address of the internal load balancer."
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_pool.id
  description = "The ID of the Load Balancer's backend address pool."
}

output "nat_rule_id" {
  value = azurerm_lb_nat_rule.http.id
  description = "The ID of the Load Balancer's HTTP NAT rule."
}
