variable "env" {
  description = "The name of the environment being deployed (e.g., internal, prod, staging). Used in naming resources."
  type        = string
}

variable "location" {
  description = "Azure region where resources are deployed."
  type        = string
}

variable "pe_type" {
  description = "The type of Private Endpoint being created, used for naming."
  type        = string
}

variable "private_connection_resource_id" {
  description = "The ID of the resource to connect to via Private Endpoint (e.g., ACR)."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the Private Endpoint will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Private Endpoint will be deployed."
  type        = string
}

variable "subresource_names" {
  description = "List of subresource names (e.g., ['sqlServer'])."
  type        = list(string)
}

variable "tags" {
  description = "Tags to be associated with the Azure Resource Group."
  type        = map(string)
}
