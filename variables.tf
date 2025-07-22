#-------------------------------------------------------------------------------------------------------------------------

## General variable
variable "env" {
  description = "Deployment environment name (internal, prod, staging)"
  type        = string
}

variable "location" {
  description = "The location where Terraform should deploy all resources"
  default     = ""
}

variable "resource_group_name" {
  description = "The name that will be assigned to the Resource Group"
  default     = ""
}

variable "tags" {
  description = "The tags that will be associated with all Terraform created resources"
  type        = map(string)
  default = {
    environment = ""
  }
}

variable "tf_subscription_id" {
  description = "The subscription ID where Terraform will deploy all resources. Used in main Provider block"
  type        = string
  default     = ""
}

#-------------------------------------------------------------------------------------------------------------------------

## Variables for ACR Private Endpoint.
variable "acr_admin_enabled" {
  description = "Enable admin access to the ACR"
  type        = bool
  default     = false
}

variable "acr_name" {
  description = "Name for ACR repository. Alphanumeric characters only. 5-50 characters."
  type        = string
}

variable "acr_public_network_access_enabled" {
  description = "Allow public access to the ACR"
  type        = bool
  default     = false
}

#-------------------------------------------------------------------------------------------------------------------------

## App Gateway Variables
variable "agw_backend_pools" {
  description = "Backend pools"
  type = list(object({
    name         = string
    ip_addresses = list(string)
  }))
}

variable "agw_capacity" {
  description = "Instance capacity for App Gateway"
  type        = number
}

variable "agw_frontend_ports" {
  description = "Frontend port objects"
  type = list(object({
    name = string
    port = number
  }))
}

variable "agw_frontend_private_ip" {
  description = "The IP address that will be assigned to the private frontend of the App Gateway"
  type        = string
}

variable "agw_http_settings" {
  description = "Backend HTTP settings"
  type = list(object({
    name            = string
    port            = number
    protocol        = string
    request_timeout = number
  }))
}

variable "agw_listeners" {
  description = "HTTP listeners"
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
    host_name                      = optional(string)
  }))
}

variable "agw_routing_rules" {
  description = "Routing rules"
  type = list(object({
    name                       = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
}

#-------------------------------------------------------------------------------------------------------------------------

## AKS Variables
variable "aks_agentpool_node_count" {
  description = "Number of Vm's in a pool"
  type        = number
}

variable "aks_agentpool_vm_size" {
  description = "VM size for a node pool"
  type        = string
}

variable "aks_dns_prefix" {
  description = "The name that will be assigned to the cluster"
  type        = string
  default     = ""
}

variable "aks_dns_service_ip" {
  description = "The IP address that will be assigned to AKS DNS Service"
  type        = string
  default     = ""
}

variable "aks_docker_bridge_cidr" {
  description = "The IP range for Docker bridge network used by AKS nodes; must not overlap with other CIDRs in the entire virtual network"
  type        = string
  default     = ""
}

variable "aks_enable_private_cluster" {
  description = "Set to TRUE to configure AKS Cluster as Private"
  type        = string
  default     = ""
}

variable "aks_kubernetes_version" {
  description = "The version of Kubernetes that will be used in the AKS Cluster"
  type        = string
  default     = ""
}

variable "aks_service_cidr" {
  description = "The CIDR that will be used for internal Kubernetes Service IPs (ClusterIP); must not overlap with other network ranges"
  type        = string
  default     = ""
}

variable "aks_sku_tier" {
  description = "The SKU tier for the K8S cluster. Values: Free or Paid (Comes with Uptime SLAs from Azure)"
  type        = string
  default     = "Free"
}

variable "aks_userpool_node_count" {
  description = "Number of Vm's in a pool"
  type        = number
}

variable "aks_userpool_vm_size" {
  description = "VM size for a node pool"
  type        = string
}

variable "aks_vm_set_type" {
  description = "The type of node pool to be created, either VirtualMachineScaleSets (Default) or AvailabilitySet (Legacy)."
  type        = string
  default     = ""
}

#-------------------------------------------------------------------------------------------------------------------------

## Keyvault Variables
variable "kv_full_access_object_ids" {
  description = "The object IDs of any additional users/service principals that will be given full access through the access policy."
  type        = list(string)
}

variable "kv_pipeline_access_object_id" {
  description = "The object ID of the user/service principal running the pipeline that will be given access through the access policy."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "kv_readonly_access_object_ids" {
  description = "The object IDs of any additional users/service principals that will be given full access through the access policy."
  type        = list(string)
}

variable "kv_tenant_id" {
  type        = string
  description = "Azure AD tenant ID. Inject via pipeline or tfvars."
}

#-------------------------------------------------------------------------------------------------------------------------

## Peering Variables
variable "np_vhub_name" {
  description = "The name of the Existing Virtual Hub within the Existing Virtual WAN"
  type        = string
  default     = ""
}

variable "np_vwan_name" {
  description = "The name of the Existing Virtual WAN being peered to"
  type        = string
  default     = ""
}

variable "np_vwan_subscription_id" {
  description = "The subscription ID of the Existing VWAN for Peering configuration. Used in Second Provider Block"
  type        = string
  default     = ""
}

variable "np_vwan_vhub_rg_name" {
  description = "The name of the Resource Group where the existing VWAN and VHUB live"
  type        = string
  default     = ""
}

#-------------------------------------------------------------------------------------------------------------------------

## Storage Account variables
variable "sa_account_tier" {
  description = "Standard or Premium"
  type        = string
  default     = "Standard"
}

variable "sa_account_replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}

variable "sa_account_kind" {
  description = "The kind of storage account (StorageV2, BlobStorage, etc)."
  type        = string
  default     = "StorageV2"
}

variable "sa_allow_nested_items_to_be_public" {
  description = "Whether public access to nested items is allowed."
  type        = bool
  default     = false
}

variable "sa_name" {
  description = "The Storage account name (must be globally unique and 3-24 lowercase letters/numbers)."
  type        = string
}

variable "sa_public_network_access_enabled" {
  description = "Allow or deny public network access (Enabled or Disabled)."
  type        = string
  default     = "Disabled"
}

#-------------------------------------------------------------------------------------------------------------------------

## Virtual Network variables
variable "vnet_address_space" {
  description = "The address space that will be assigned for the Virutal Network"
  type        = string
  default     = ""
}

variable "vnet_agw_subnet_cidr" {
  description = "CIDR for use by AGW exclusive subnet"
  type        = string
}

variable "vnet_aks_nodes_subnet_cidr" {
  description = "CIDR for use by AGW exclusive subnet"
  type        = string
}

variable "vnet_private_subnet_prefix" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "vnet_public_subnet_prefix" {
  description = "CIDR block for the public subnet"
  type        = string
}