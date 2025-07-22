variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to be associated with the Azure Resource Group"
  type        = map(string)
}

variable "vnet_name" {
  description = "The name of the virtual network to be created."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network, in CIDR notation."
  type        = string
}

variable "private_subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

# variable "public_subnets" {
#   type = list(object({
#     name           = string
#     address_prefix = string
#   }))
# }


#Need to delete this VM this VM is just for testing
variable "nic" {
  description = "This is to create NIC for a VM"
  type        = string
  default     = "IaC-VM-NIC"
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be created"
  type        = string
}

# variable "backend_address_pool_id" {
#   description = "The ID of the Load Balancer's backend address pool."
#   type        = string
# }


# variable "nat_rule_id" {
#   description = "The ID of the Load Balancer's NAT rule."
#   type        = string
# }
