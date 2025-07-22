## This module is used to create the network peering between the Terraform-created 
## AKS virtual network and the existing, pre-exiting VWAN/VHUB

## Data object to retrieve existing, non-Terraform-created vhub information
data "azurerm_virtual_wan" "shared_vwan" {
  provider            = azurerm.vwan
  name                = var.vwan_name
  resource_group_name = var.vwan_rg_name
}

## Data object to retrieve existing, non-Terraform-created vhub information
data "azurerm_virtual_hub" "shared_vhub" {
  provider            = azurerm.vwan
  name                = var.vhub_name
  resource_group_name = var.vwan_rg_name
}

## Create Virtual Hub Connection using information above.
resource "azurerm_virtual_hub_connection" "vnet_to_vwan" {
  name = "${var.vhub_name}-to-${var.virtual_network_name}"
  virtual_hub_id            = data.azurerm_virtual_hub.shared_vhub.id
  remote_virtual_network_id = var.remote_virtual_network_id
  internet_security_enabled = false
}