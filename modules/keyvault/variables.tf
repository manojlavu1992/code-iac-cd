variable "env" {
  description = "Deployment environment name (internal, prod, staging). Used for naming resources."
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault should be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID for the Key Vault."
  type        = string
}

variable "full_access_object_ids" {
  description = "List of object IDs (users or service principals) that will be granted full access to the Key Vault."
  type        = list(string)
}

variable "pipeline_access_object_id" {
  description = "Object ID of the pipeline identity (user or service principal) that will be granted limited access for CI/CD purposes."
  type        = string
}

variable "readonly_access_object_ids" {
  description = "List of object IDs (users or service principals) that will be granted read-only access to the Key Vault."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to associate with the Key Vault and related resources."
  type        = map(string)
  default     = {
    environment = ""
  }
}
