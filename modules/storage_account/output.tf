output "storage_account_id" {
  description = "ID of the storage account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "Name of the storage account."
  value       = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}