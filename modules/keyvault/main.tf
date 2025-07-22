## This module is used to create the Azure Keyvault
resource "azurerm_key_vault" "keyvault" {
  name                        = "kv-${var.env}-cc"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  tags                        = var.tags
}

## This block grants access to the service principal that runs the pipeline, to ensure necessary access for deployment.
resource "azurerm_key_vault_access_policy" "pipeline_access" {
  tenant_id    = var.tenant_id
  object_id    = var.pipeline_access_object_id
  key_vault_id = azurerm_key_vault.keyvault.id

  secret_permissions = [
    "Get", "List"
  ]
}

## Creates Read Only access policies for each object ID in readonly_access_object_ids.
resource "azurerm_key_vault_access_policy" "readonly_access" {
  for_each = length(var.readonly_access_object_ids) > 0 ? toset(var.readonly_access_object_ids) : toset([])
  tenant_id = var.tenant_id
  object_id = each.value
  key_vault_id = azurerm_key_vault.keyvault.id
  secret_permissions = [
    "Get", "List"
  ]
}

## Creates full access policies for each object ID in full_access_object_ids.
resource "azurerm_key_vault_access_policy" "full_access" {
  for_each = length(var.full_access_object_ids) > 0 ? toset(var.full_access_object_ids) : toset([])
  tenant_id = var.tenant_id
  object_id = each.value
  key_vault_id = azurerm_key_vault.keyvault.id
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Backup", "Restore"
  ]
}

## Example block of a secret if one needs to be deployed for debugging purposes.
#resource "azurerm_key_vault_secret" "example" {
#  name         = "example-secret"
#  value        = "secret-value"
#  key_vault_id = azurerm_key_vault.example.id
#}