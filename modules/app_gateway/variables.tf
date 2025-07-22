variable "backend_pools" {
  description = "A list of backend address pools. Each pool includes a name and the list of IP addresses of backend targets."
  type = list(object({
    name         = string
    ip_addresses = list(string)
  }))
}

variable "capacity" {
  description = "The instance capacity to be allocated to the Application Gateway. This defines the number of instances."
  type        = number
}

variable "env" {
  description = "The deployment environment (e.g., internal, staging, prod). Used for naming resources."
  type        = string
}

variable "frontend_ports" {
  description = "A list of frontend ports for the Application Gateway to listen on. Each object defines a name and port number."
  type = list(object({
    name = string
    port = number
  }))
}

variable "frontend_private_ip" {
  description = "Static private IP address assigned to the private frontend configuration of the Application Gateway."
  type        = string
}

variable "http_settings" {
  description = "A list of backend HTTP settings including port, protocol, and timeout values for each backend pool."
  type = list(object({
    name            = string
    port            = number
    protocol        = string
    request_timeout = number
  }))
}

variable "listeners" {
  description = "A list of HTTP listeners that define how the Application Gateway listens for incoming requests. Includes frontend IP config and port."
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
    host_name                      = optional(string)
  }))
}

variable "location" {
  description = "The Azure region where the Application Gateway will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group in which the Application Gateway will be deployed."
  type        = string
}

variable "routing_rules" {
  description = "A list of request routing rules that define how requests are directed from listeners to backend pools."
  type = list(object({
    name                       = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
}

variable "subnet_id" {
  description = "The ID of the subnet within which the Application Gateway will be deployed. This should be a dedicated subnet."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the Application Gateway for resource organization and cost tracking."
  type        = map(string)
}
