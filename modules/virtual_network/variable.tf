variable "agw_cidr" {
  description = "The address space for the dedicated application gateway subnet, in CIDR notation."
  type = string
}

variable "aks_nodes_subnet_cidr" {
  description = "Name of the cluster"
  type        = string
}

variable "env" {
  description = "Deployment environment name (internal, prod, staging)"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be deployed."
  type        = string
}

variable "private_subnet_prefix" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "public_subnet_prefix" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to be associated with the Azure Resource Group"
  type        = map(string)
}

variable "vnet_address_space" {
  description = "The address space for the virtual network, in CIDR notation."
  type        = string
}