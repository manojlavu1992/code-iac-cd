# Includes output value definitions.
# terraform output private_subnet_id
# Use output cmd to get private id's

#output "resource_group_name" {
#  value       = module.resource_group.resource_group_name
#  description = "The name of the Resource group created in the module."
#}
#
#output "location" {
#  value       = module.resource_group.location
#  description = "The name of the Resource group created in the module."
#}


# output "vnet_name" {
#   value       = module.virtual_network.virtual_network_name
#   description = "The name of the virtual network created in the module."
# }

# output "vnet_id" {
#   value       = module.virtual_network.virtual_network_id
#   description = "The ID of the virtual network created in the module."
# }

# output "public_subnet_ids" {
#   value       = module.virtual_network.public_subnet_ids
#   description = "The IDs of the public subnets created in the module."
# }

# output "private_subnet_id" {
#   value       = module.virtual_network.private_subnet_id
#   description = "The IDs of the private subnets created in the module."
# }

# output "public_subnet_names" {
#   value       = module.virtual_network.public_subnet_names
#   description = "The names of the public subnets created in the module."
# }

# output "private_subnet_names" {
#   value       = module.virtual_network.private_subnet_names
#   description = "The names of the private subnets created in the module."
# }

# output "kube_config" {
#   value       = module.aks.kube_config
#   sensitive   = true
#   description = "Kubeconfig for accessing the AKS cluster. Sensitive data."
# }

#output "debug_subnet_ids" {
#  value = module.virtual_network.private_subnet_id
#}