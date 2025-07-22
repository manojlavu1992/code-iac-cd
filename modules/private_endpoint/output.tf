output "private_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.id
}

output "private_ip_addresses" {
  description = "Private IP addresses assigned to the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.private_service_connection[0].private_ip_address
}