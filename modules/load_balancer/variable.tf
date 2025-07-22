variable "location" {
  description = "The Azure region where resources will be deployed."
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Load Balancer will be located."
  type        = string
}
