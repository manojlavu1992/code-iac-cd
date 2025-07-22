## This module is used to create the Azure Private Endpoints for use by internal resources.
## Azure private endpoints are necessary to connect securely to Azure Services (Eg. Keyvault)
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.env}-cc-${var.pe_type}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.env}-cc-${var.pe_type}"
    is_manual_connection           = false
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
  }
  tags                = var.tags
}