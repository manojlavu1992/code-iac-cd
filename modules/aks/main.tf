## This module is used to create the AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  name                = "aks-${var.env}-cc"
  resource_group_name = var.resource_group_name
  sku_tier            = var.sku_tier

  ## Creates the System node pool
  default_node_pool {
    name           = "agentpool"
    node_count     = var.agentpool_node_count
    type           = var.vm_set_type
    vm_size        = var.agentpool_vm_size
    vnet_subnet_id = var.vnet_subnet_id
    zones          = [1, 2, 3]
    ## Block added to prevent resource flapping. Will abstract when we have discussions around scaling.
    upgrade_settings {
      drain_timeout_in_minutes      = 0 
      max_surge                     = "10%" 
      node_soak_duration_in_minutes = 0
    }
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    network_plugin_mode = "overlay"
    outbound_type      = "userAssignedNATGateway"
    dns_service_ip     = var.dns_service_ip
    load_balancer_sku  = "standard"
    service_cidr       = var.service_cidr
  }

  identity {
    type = "SystemAssigned"
  }
  
  private_cluster_enabled = var.enable_private_cluster
  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.userpool_vm_size
  node_count            = var.userpool_node_count
  vnet_subnet_id        = var.vnet_subnet_id
  mode                  = "User"
  orchestrator_version  = var.kubernetes_version
  min_count             = null
  max_count             = null
  os_type               = "Linux"
  ## Block added to prevent resource flapping. Will abstract when we have discussions around scaling.
  upgrade_settings {
    drain_timeout_in_minutes      = 0 
    max_surge                     = "10%" 
    node_soak_duration_in_minutes = 0
  }
  node_labels = {
    "role" = "app"
  }
  tags = var.tags
}