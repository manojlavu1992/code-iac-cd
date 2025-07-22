## This module is used to create the storage account for use by applications
resource "azurerm_storage_account" "storage_account" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  https_traffic_only_enabled = true
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  min_tls_version           = "TLS1_2"

  ## Additional security measure. Only AzureServices and the subnets in var.subnet_ids will be allowed access
  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = var.subnet_ids
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}
