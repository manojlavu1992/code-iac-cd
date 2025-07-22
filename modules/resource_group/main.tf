## This module is used to create the resource group for the deployments
## Depending on final setup, this may or may not be necessary
resource "azurerm_resource_group" "deployment_resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}