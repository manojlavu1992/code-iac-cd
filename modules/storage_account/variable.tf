variable "account_kind" {
  description = "The kind of storage account (e.g., StorageV2, BlobStorage, etc.)."
  type        = string
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Replication type for the storage account (e.g., LRS, GRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "account_tier" {
  description = "The performance tier of the storage account (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "allow_nested_items_to_be_public" {
  description = "Whether public access to nested items (blobs) is allowed."
  type        = bool
  default     = false
}

variable "location" {
  description = "Azure region where the storage account will be deployed."
  type        = string
}

variable "name" {
  description = "The name of the storage account (must be globally unique and 3-24 lowercase letters/numbers)."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Controls public network access to the storage account (Enabled or Disabled)."
  type        = string
  default     = "Disabled"
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the storage account into."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs allowed to access the storage account."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default     = {}
}
