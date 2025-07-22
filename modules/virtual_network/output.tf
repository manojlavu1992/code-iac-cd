output "virtual_network_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the virtual network."
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the virtual network."
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}

output "public_subnet_ids" {
  value = azurerm_subnet.public.id
}

output "agw_subnet_id" {
  description = "ID of the subnet for the Application Gateway"
  value       = azurerm_subnet.agw_subnet.id
}

output "aks_nodes_subnet_id" {
  description = "ID of the subnet for the Application Gateway"
  value       = azurerm_subnet.aks_nodes_subnet.id
}