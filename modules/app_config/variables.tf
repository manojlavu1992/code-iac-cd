variable "env" {
  description = "The deployment environment (e.g., internal, staging, prod). Used to generate environment-specific resource names."
  type        = string
}

variable "location" {
  description = "The Azure region where the App Configuration resource will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group in which the App Configuration will be created."
  type        = string
}

variable "sku" {
  description = "The pricing tier (SKU) for the App Configuration resource. Valid values include 'free' and 'standard'."
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A map of tags to apply to the App Configuration resource for organization and cost management."
  type        = map(string)
  default     = {}
}
