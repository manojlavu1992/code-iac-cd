## This module is used to create the Virtual Network and all its accompanying resources.

## Creation of public IP needed for NAT Gateway
resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "pip-${var.env}-cc-natgateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

## Creation of Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vn-${var.env}-cc-k8sinfra"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
  #dns_servers        = ["172.16.1.13", "172.16.1.11", "172.16.201.4"] ## ClearD DNS servers for full deployment
  dns_servers         = ["168.63.129.16"] ## Azure DNS servers, for testing phase
  tags                = var.tags
}

## Private Subnet for AKS or internal resources
resource "azurerm_subnet" "private" {
  name                 = "subnet-${var.env}-cc-private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_prefix]
  service_endpoints    = ["Microsoft.Storage"] ## Required for Storage Account Private Endpoint 
}

## Public Subnet if needed
resource "azurerm_subnet" "public" {
  name                 = "subnet-${var.env}-cc-public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_prefix]
}

resource "azurerm_subnet" "agw_subnet" {
  name                 = "subnet-${var.env}-cc-agw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.agw_cidr]
}


resource "azurerm_subnet" "aks_nodes_subnet" {
  name                 = "subnet-${var.env}-cc-aksnodes"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_nodes_subnet_cidr]
}

## Creation of NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "ngw-${var.env}-cc"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

## Associates IP with NAT gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip.id
}

## Associates NAT Gateway with Private Subnet
resource "azurerm_subnet_nat_gateway_association" "nat_assoc" {
  subnet_id      = azurerm_subnet.aks_nodes_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

## Creates NSG for the AKS Node Subnet
resource "azurerm_network_security_group" "aks_node_nsg" {
  name                = "nsg-${var.env}-aks-nodes"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowOutboundInternet"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}
## Associates NSG with AKS node subnet
resource "azurerm_subnet_network_security_group_association" "aks_node_nsg_assoc" {
  subnet_id                 = azurerm_subnet.aks_nodes_subnet.id
  network_security_group_id = azurerm_network_security_group.aks_node_nsg.id
}

## Creates route table to ensure NAT Gateway is used by nodes
resource "azurerm_route_table" "aks_routetable" {
  name                = "rt-${var.env}-aks-nodes"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
  route {
    name           = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

## Associates route table with subnet
resource "azurerm_subnet_route_table_association" "aks_subnet_rt_assoc" {
  subnet_id      = azurerm_subnet.aks_nodes_subnet.id
  route_table_id = azurerm_route_table.aks_routetable.id
}

resource "azurerm_private_dns_zone" "aks_dns_zone" {
  name                = "privatelink.canadacentral.azmk8s.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_zone_link" {
  name                  = "aks-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}