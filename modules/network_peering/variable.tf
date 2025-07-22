variable "remote_virtual_network_id" {
  description = "The ID of the virtual network to peer."
  type        = string
}

variable "vhub_name" {
  description = "The name of the Virtual Hub to peer with."
  type        = string
}

variable "vhub_rg_name" {
  description = "The name of the resource group containing the Virtual Hub."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the local virtual network to be peered."
  type        = string
}

variable "vwan_name" {
  description = "The name of the Virtual WAN associated with the Virtual Hub."
  type        = string
}

variable "vwan_rg_name" {
  description = "The name of the resource group containing the Virtual WAN."
  type        = string
}
