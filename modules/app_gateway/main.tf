## This module is used to create the App Gateway that will support both internal and external traffic

## Creates public IP for use by App Gateway
resource "azurerm_public_ip" "agw_public_ip" {
  name                = "pip-${var.env}-cc-agw"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgateway" {
  name                = "agw-${var.env}-cc"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "gipc-${var.env}-cc"
    subnet_id = var.subnet_id
  }

  ## Frontend to be used for incoming traffic from internet
  frontend_ip_configuration {
    name                 = "fipc-${var.env}-cc-public"
    public_ip_address_id = azurerm_public_ip.agw_public_ip.id
  }

  ## Frontend to be used for incoming traffic from local resources
  frontend_ip_configuration {
    name                          = "fipc-${var.env}-cc-private"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.frontend_private_ip
    subnet_id                     = var.subnet_id
  }

  ## Creates all port allowances for the App Gateway itself from variable
  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  ## Creates the backend pools for traffic to be directed to
  dynamic "backend_address_pool" {
    for_each = var.backend_pools
    content {
      name         = backend_address_pool.value.name
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  ## Creates http configs from variable
  dynamic "backend_http_settings" {
    for_each = var.http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = "Disabled"
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }
  ## Creates all listeners from variable
  dynamic "http_listener" {
    for_each = var.listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
    }
  }

  ## Creates routing rules from variable
  dynamic "request_routing_rule" {
    for_each = var.routing_rules
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = "Basic"
      priority                   = request_routing_rule.value.priority 
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }
}
