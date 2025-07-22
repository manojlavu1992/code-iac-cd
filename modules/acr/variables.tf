variable "acr_name" {
  description = "Specifies the name of the Azure Container Registry (ACR). Must be 5-50 alphanumeric characters."
  type        = string
}

variable "admin_enabled" {
  description = "Determines whether the ACR admin user account is enabled. This provides access credentials for tools like Docker."
  type        = bool
  default     = false
}

variable "env" {
  description = "The deployment environment (e.g., dev, staging, prod). Used to generate environment-specific resource names."
  type        = string
}

variable "location" {
  description = "The Azure region where the ACR will be created."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Indicates whether the ACR is accessible over the public internet. Set to false to restrict access to private endpoints only."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group in which the ACR will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the ACR resource for tracking and management purposes."
  type        = map(string)
  default     = {}
}
