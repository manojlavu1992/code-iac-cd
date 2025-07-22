# Resource group
resource_group_name = "IaC-ClearD-Internal-Resource-Group"
location            = "Canada Central"
tags = {
  environment = "Dev-&-QA"
}

# Virtual Network
vnet_name          = "IaC-ClearD-Internal-Virtual-Network"
vnet_address_space = "172.17.0.0/16"
private_subnets = [
  { name = "Subnet-1", address_prefix = "172.17.8.0/22" },
  { name = "Subnet-2", address_prefix = "172.17.20.0/22" },
  { name = "Subnet-3", address_prefix = "172.17.28.0/22" }
]
public_subnets = [
  { name = "ingress-appgateway-subnet", address_prefix = "172.17.1.0/24" },
  { name = "ingress-loadbalancer-subnet", address_prefix = "172.17.2.0/24" }
]


# Network peering
iac_to_cleard_peering        = "IaC-to-ClearD-Peering"
existing_to_iac_peering      = "ClearD-To-IaC-Peering"
iac_remote_network_id        = "/subscriptions/14d226b1-056e-4c74-9ff0-2d2e4b6ed307/resourceGroups/IaC-ClearD-Internal-Resource-Group/providers/Microsoft.Network/virtualNetworks/IaC-Cleard-Internal-Virtual-Network"
existing_remote_network_id   = "/subscriptions/14d226b1-056e-4c74-9ff0-2d2e4b6ed307/resourceGroups/ClearD-Admin-Resource-Group/providers/Microsoft.Network/virtualNetworks/Cleard-Admin-Virtual-Network"
existing_resource_group_name = "ClearD-Admin-Resource-Group"
existing_vnet_name           = "ClearD-Admin-Virtual-Network"

# Virtual Wan Peering
virtual_hub_id = "/subscriptions/14d226b1-056e-4c74-9ff0-2d2e4b6ed307/resourceGroups/ClearD-Admin-Resource-Group/providers/Microsoft.Network/virtualHubs/ClearD-Virtual-WAN"
vhub_name = "Virtual-HUB-ClearD"

# Private Endpoint for ACR
acr_private_endpoint       = "IaC-ClearD-Private-Endpoint"
private_service_connection = "IaC-ClearD-Private-Service-Connection"
private_dns_zone_group     = "IaC-ClearD-Private-DNS-Zone"
acr_dns_zone               = "privatelink.azurecr.io"
acr_dns_zone_link          = "IaC-ClearD-DNS-Zone-Link"
acr_id                     = "/subscriptions/14d226b1-056e-4c74-9ff0-2d2e4b6ed307/resourceGroups/ClearD-Admin-Resource-Group/providers/Microsoft.ContainerRegistry/registries/cleard"


#AKS Cluster
cluster_name = "IaC-ClearD-Internal-K8s"
kubernetes_version     = "1.27.9"
sku_tier = "Free"
aks_docker_bridge_cidr  = "172.17.0.1/16"
node_pool_vm_size      = "Standard_DS2_v2"
node_pool_count        = 2
vm_set_type            = "VirtualMachineScaleSets"
aks_service_cidr       = "10.10.0.0/16"
aks_dns_service_ip     = "10.10.0.10"


# iac_tfstate = "iactfstate"
# container_name = "terraform-state"
# account_tier = "Standard"
# account_replication_type = "LRS"
