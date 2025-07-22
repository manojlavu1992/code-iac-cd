## Block to create Load Balancer for incoming requests
resource "azurerm_lb" "internal" {
  name                = "internal-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "internal-frontend"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.internal.id
  name            = "internal-backend-pool"
}

resource "azurerm_lb_probe" "probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.internal.id
  protocol            = "Http"
  request_path        = "/"
  port                = 80
  #resource_group_name = var.resource_group_name
}

resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.internal.id
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 80
  frontend_ip_configuration_name = "internal-frontend"
  probe_id                       = azurerm_lb_probe.probe.id
  #resource_group_name            = var.resource_group_name
  #backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_nat_rule" "http" {
  name                          = "HTTPAccess"
  resource_group_name           = var.resource_group_name
  loadbalancer_id               = azurerm_lb.internal.id
  protocol                      = "Tcp"
  frontend_port                 = 80
  backend_port                  = 80
  frontend_ip_configuration_name = "internal-frontend"
  enable_floating_ip            = false
}


# resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_association" {
#   network_interface_id    = azurerm_network_interface.nic.id
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
# }
