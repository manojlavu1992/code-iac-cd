## This module is used to create the Azure App Config, for configuration storage to be utilized by AKS pods
resource "azurerm_app_configuration" "appconfig" {
  name                = "ac-${var.env}-cc"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags
}