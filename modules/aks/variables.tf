variable "agentpool_node_count" {
  description = "Number of Vm's in the system nodepool."
  type        = number
}

variable "agentpool_vm_size" {
  description = "Instance type to be used for system nodepool nodes."
  type        = string
}

variable "dns_prefix" {
  description = "Prefix to be attached to DNS hostnames associated with Kubernetes resources."
  type        = string
}

variable "dns_service_ip" {
  description = "The IP address within the Kubernetes service CIDR that will be assigned to the DNS service. This IP must be unique and not overlap with other services."
  type        = string
}

variable "docker_bridge_cidr" {
  description = "The CIDR notation IP range assigned to the Docker bridge network used by AKS nodes. It must not overlap with any other IP ranges in your network."
  type        = string
}

variable "enable_private_cluster" {
  description = "True or False. Makes cluster accessible/inaccessible from the internet."
  type        = string
}

variable "env" {
  description = "Env currently being deployed, for use in generating resource name."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes the cluster will utilize."
  type        = string
}

variable "location" {
  description = "The location that the resources will be deployed in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group that resources will be deployed in."
  type        = string
}

variable "service_cidr" {
  description = "The IP address range for the Kubernetes service network. This range is used by Kubernetes services and must not overlap with other address ranges in your network."
  type        = string
}

variable "sku_tier" {
  description = "Default SKU tier is set to Free used for Dev, QA and STG."
  type = string
}

variable "tags" {
  description = "Tags to be associated with the resource."
  type        = map(string)
}

variable "userpool_node_count" {
  description = "The number of nodes that will be created for the userpool."
  type        = number
}

variable "userpool_vm_size" {
  description = "The instance type that will be used by VMs in the userpool."
  type        = string
}

variable "vm_set_type" {
  description = "The type of node pool to be created, either VirtualMachineScaleSets (Default) or AvailabilitySet (Legacy)."
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "vnet_subnet_id" {
  description = "The Virtual network subnet ID where the node pools should be deployed."
  type        = string
}
