## General variables
env = "aptumdev"
location            = "Canada Central"  ## Region where Terraform resources will be deployed
resource_group_name = "rg-aptumdev-cc" ## Resource group where Terraform resources will be deployed
## Tags will be attached to all applicable resources
tags = { 
  Environment = "aptumdev"
  System = "Kubernetes"
  Region = "Canada Central"
  PowerSchedule = "24x7" 
}
tf_subscription_id  = "6889ac83-94dd-40bc-a2c2-346ea8ed9943" ## Subscription where Terraform resources will be deployed.

#-------------------------------------------------------------------------------------------------------------------------

## Azure Container Registry Variables
acr_admin_enabled = "true"
acr_name = "amptumdevtestreg" ## Name for ACR repository. Alphanumeric characters only. 5-50 characters.
acr_public_network_access_enabled =  "false" 

#-------------------------------------------------------------------------------------------------------------------------

## Application Gateway Variables
agw_capacity   = 1 ## One is good for dev, two for prod
agw_frontend_private_ip = "172.23.20.50" ## Must be within the agw_subnet CIDR
agw_backend_pools = [
  {
    name         = "aks-backend"
    ip_addresses = []
  },
  {
    name         = "vm-backend"
    ip_addresses = ["10.0.3.4", "10.0.3.5"] ## IPs of service/app VMs heres.
  }
]

agw_http_settings = [
  {
    name            = "http-aks"
    port            = 80
    protocol        = "Http"
    request_timeout = 20
  },
  {
    name            = "http-vm"
    port            = 8080
    protocol        = "Http"
    request_timeout = 20
  }
]

## A list of all ports that should be available on the AGW, public AND private. Please specify which for clearer naming
agw_frontend_ports = [
  { name = "port-80-public", port = 80 }, 
  { name = "port-8080-private", port = 8080 } 
]

agw_listeners = [
  ## Replicate this block as needed, specifying public_frontend or private_frontend 
  {
    name                            = "agwl-aptumdev-cc-public-http"
    frontend_ip_configuration_name  = "fipc-aptumdev-cc-public"
    frontend_port_name              = "port-80-public"
    protocol                        = "Http"
  },
  {
    name                            = "agwl-aptumdev-cc-private-http"
    frontend_ip_configuration_name  = "fipc-aptumdev-cc-private"
    frontend_port_name              = "port-8080-private"
    protocol                        = "Http"
  }
]

agw_routing_rules = [
  {
    name                       = "route-to-aks"
    http_listener_name         = "agwl-aptumdev-cc-public-http"
    backend_address_pool_name  = "aks-backend"
    backend_http_settings_name = "http-aks"
    priority                   = 100
  },
  {
    name                       = "route-to-vm"
    http_listener_name         = "agwl-aptumdev-cc-private-http"
    backend_address_pool_name  = "vm-backend"
    backend_http_settings_name = "http-vm"
    priority                   = 200
  }
]

#-------------------------------------------------------------------------------------------------------------------------

## AKS Cluster Variables
aks_agentpool_node_count = 1
aks_agentpool_vm_size = "Standard_D2s_v3"
aks_dns_prefix = "aptumdev" ## Prefix to be assigned to local DNS resolution
aks_dns_service_ip = "10.240.0.10" ## IP address that will be assigned to internal DNS service
aks_docker_bridge_cidr  = "172.23.0.1/16"
aks_enable_private_cluster = true
aks_kubernetes_version = "1.32.5" ## Kubernetes version to be used by cluster
aks_service_cidr = "10.240.0.0/16" ## CIDR to be used by Kubernetes Services
aks_sku_tier = "Free" ## Free OR Paid
aks_userpool_node_count = 2
aks_userpool_vm_size = "Standard_D2s_v3"
aks_vm_set_type = "VirtualMachineScaleSets"

#-------------------------------------------------------------------------------------------------------------------------

## Key Vault Variables 
kv_full_access_object_ids = ["7906d005-59a7-4832-9ea2-384bf1b842e1"] ## Set to [] to skip access policy creation 
kv_pipeline_access_object_id = "94f1a285-2563-4f62-bc38-0071820e6e3d"
kv_readonly_access_object_ids = [] ## Set to [] to skip access policy creation 
kv_tenant_id = "efbf251b-178d-4c31-87f7-e386b41ede1e"

#-------------------------------------------------------------------------------------------------------------------------
## Peering variables
## The variables here are used during peering creation. Below is what will be peered to the virutal network created by Terraform.
np_vhub_name = "Virtual-HUB-ClearD" ## Name of pre-existing vhub
np_vwan_name = "ClearD-Virtual-WAN" ## Name of pre-existing VWAN
np_vwan_subscription_id = "14d226b1-056e-4c74-9ff0-2d2e4b6ed307" ## Subscription with pre-existing VWAN/VHUB
np_vwan_vhub_rg_name = "ClearD-Admin-Resource-Group" ## Resource group where existing vwan and vhub are

#-------------------------------------------------------------------------------------------------------------------------

## Storage Account variables
sa_account_kind = "BlobStorage"
sa_account_replication_type = "LRS" ## See https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy for different replication options
sa_account_tier = "Standard"
sa_allow_nested_items_to_be_public = false
sa_name = "aptumdevtestsa" ## Must be globally unique and 3-24 lowercase letters/numbers

#-------------------------------------------------------------------------------------------------------------------------

## Virtual Network variables
vnet_address_space = "172.23.0.0/16"
vnet_agw_subnet_cidr = "172.23.20.0/24" 
vnet_aks_nodes_subnet_cidr = "172.23.100.0/22"
vnet_private_subnet_prefix = "172.23.0.0/24"
vnet_public_subnet_prefix = "172.23.30.0/24" 
