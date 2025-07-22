### Main Terraform file for all environments
## AzureRM provider allows control of Azure resources by Terraform
provider "azurerm" {
  features {
    resource_group {
      ## This can be very dangerous in certain circumstances, but helps `terraform destroy` run without issue.
      ## Should be removed once IAC is being used in Production to help prevent unintentional data loss
      prevent_deletion_if_contains_resources = false
    }
  }
  ## Uncommenting will make Terraform use a Managed Identity or Service Principal with RBAC instead of for access_key instead of ENV variable
  ## key = "prod.terraform.tfstate" ## Alternative to environment variable method for Access Key. 
  subscription_id = var.tf_subscription_id ## Subscription where all Terraform resources will be deployed
}

## Second AzureRM provider is used to access VWAN information from separate subscription. 
provider "azurerm" {
  alias = "vwan"
  features {}
  subscription_id = var.np_vwan_subscription_id
}

## Makefile configuration ensures that the correct terraform.tfvars files from the environments directory are being utilized.
module "acr_private_endpoint" {
  source                         = "./modules/private_endpoint"
  depends_on                     = [module.virtual_network, module.acr]
  env                            = var.env
  location                       = var.location
  resource_group_name            = var.resource_group_name
  tags                           = var.tags
  pe_type                        = "acr"
  private_connection_resource_id = module.acr.acr_id
  subnet_id                      = module.virtual_network.private_subnet_id
  subresource_names              = ["registry"]
}
## All subsequent blocks are calling the created modules to deploy their respective resources.

module "acr" {
  source                        = "./modules/acr"
  env                           = var.env
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tags                          = var.tags
  acr_name                      = var.acr_name
  admin_enabled                 = var.acr_admin_enabled
  public_network_access_enabled = var.acr_public_network_access_enabled
}

module "aks" {
  source                 = "./modules/aks"
  depends_on             = [module.virtual_network]
  env                    = var.env
  location               = var.location
  resource_group_name    = var.resource_group_name
  tags                   = var.tags
  agentpool_node_count   = var.aks_agentpool_node_count
  agentpool_vm_size      = var.aks_userpool_vm_size
  dns_prefix             = var.aks_dns_prefix
  dns_service_ip         = var.aks_dns_service_ip
  docker_bridge_cidr     = var.aks_docker_bridge_cidr
  enable_private_cluster = var.aks_enable_private_cluster
  kubernetes_version     = var.aks_kubernetes_version
  service_cidr           = var.aks_service_cidr
  sku_tier               = var.aks_sku_tier
  userpool_node_count    = var.aks_userpool_node_count
  userpool_vm_size       = var.aks_agentpool_vm_size
  vm_set_type            = var.aks_vm_set_type
  vnet_subnet_id         = module.virtual_network.aks_nodes_subnet_id
}

module "app_config" {
  source              = "./modules/app_config"
  env                 = var.env
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

module "app_gateway" {
  source              = "./modules/app_gateway"
  depends_on          = [module.virtual_network]
  env                 = var.env
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  backend_pools       = var.agw_backend_pools
  capacity            = var.agw_capacity
  frontend_ports      = var.agw_frontend_ports
  frontend_private_ip = var.agw_frontend_private_ip
  http_settings       = var.agw_http_settings
  listeners           = var.agw_listeners
  routing_rules       = var.agw_routing_rules
  subnet_id           = module.virtual_network.agw_subnet_id
}

module "keyvault" {
  source                     = "./modules/keyvault"
  env                        = var.env
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tags                       = var.tags
  full_access_object_ids     = var.kv_full_access_object_ids
  pipeline_access_object_id  = var.kv_pipeline_access_object_id
  readonly_access_object_ids = var.kv_readonly_access_object_ids
  tenant_id                  = var.kv_tenant_id
}

module "network_peering" {
  source = "./modules/network_peering"
  providers = {
    azurerm      = azurerm      ## Default provider
    azurerm.vwan = azurerm.vwan ## Second provider for data
  }
  depends_on                = [module.virtual_network]
  remote_virtual_network_id = module.virtual_network.virtual_network_id
  vhub_name                 = var.np_vhub_name
  vhub_rg_name              = var.np_vwan_vhub_rg_name
  virtual_network_name      = module.virtual_network.virtual_network_name
  vwan_name                 = var.np_vwan_name
  vwan_rg_name              = var.np_vwan_vhub_rg_name
}

## Removed. Must be created manually BEFORE deployment of Terraform to ensure necessary permissions can be pre-assigned
##module "resource_group" {
##  source              = "./modules/resource_group"
##  location            = var.location
##  resource_group_name = var.resource_group_name
##  tags                = var.tags
##}

module "sa_private_endpoint_blob" {
  source                         = "./modules/private_endpoint"
  depends_on                     = [module.virtual_network, module.storage_account]
  env                            = var.env
  location                       = var.location
  resource_group_name            = var.resource_group_name
  tags                           = var.tags
  pe_type                        = "sa-blob"
  private_connection_resource_id = module.storage_account.storage_account_id
  subnet_id                      = module.virtual_network.private_subnet_id
  subresource_names              = ["blob"]
}


module "sa_private_endpoint_fileshare" {
  source                         = "./modules/private_endpoint"
  depends_on                     = [module.virtual_network, module.storage_account]
  env                            = var.env
  location                       = var.location
  resource_group_name            = var.resource_group_name
  tags                           = var.tags
  pe_type                        = "sa-fileshare"
  private_connection_resource_id = module.storage_account.storage_account_id
  subnet_id                      = module.virtual_network.private_subnet_id
  subresource_names              = ["blob"]
}

module "storage_account" {
  source                          = "./modules/storage_account"
  depends_on                      = [module.virtual_network]
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tags                            = var.tags
  account_kind                    = var.sa_account_kind
  account_replication_type        = var.sa_account_replication_type
  account_tier                    = var.sa_account_tier
  allow_nested_items_to_be_public = var.sa_allow_nested_items_to_be_public
  name                            = var.sa_name
  subnet_ids                      = [module.virtual_network.private_subnet_id] ## Only subnets here will be allowed to access the Storage Account
}

module "virtual_network" {
  source                = "./modules/virtual_network"
  env                   = var.env
  location              = var.location
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  agw_cidr              = var.vnet_agw_subnet_cidr
  aks_nodes_subnet_cidr = var.vnet_aks_nodes_subnet_cidr
  private_subnet_prefix = var.vnet_private_subnet_prefix
  public_subnet_prefix  = var.vnet_public_subnet_prefix
  vnet_address_space    = var.vnet_address_space
}

## VM for testing
# module "azure_vm" {
#   source              = "./modules/virtual_machine"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   vnet_name           = var.vnet_name
#   vnet_address_space  = var.vnet_address_space
#   private_subnets     = var.private_subnets
#   subnet_id           = module.virtual_network.private_subnet_id["Subnet-1"]
#   tags                = var.tags
#   # backend_address_pool_id = module.load_balancer.backend_pool_id
#   # nat_rule_id             = module.load_balancer.nat_rule_id
#   depends_on = [module.virtual_network]
# }