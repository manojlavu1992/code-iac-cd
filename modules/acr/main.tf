## This module is used to create the Azure Container Registry for storing cluster environment/application images
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Premium" ## Required for Private Endpoint
  admin_enabled            = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags = var.tags
}
