## This document creates a VM and its associated objects for use during testing. It will not be a part of the final deployment.
## Creation of Network Security group for use by Test VM
resource "azurerm_network_security_group" "nsg" {
  name                = "iac-vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags                = var.tags
}

## Creation of NSG Association for use by Test VM
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  tags                = var.tags
}

## Creation of NIC for use by Test VM
resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.iac_public_ip.id
  }
  tags                = var.tags
}

## Creation of Virtual Machine itself
resource "azurerm_linux_virtual_machine" "iac_vm" {
  name                            = "Terraform-Test-VM"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_B1s"
  admin_username                  = "tfuser"
  admin_password                  = "ClearDestination@321"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  tags                = var.tags
}


## Pre-existing code. Moved to bottom of file incase its needed in the future
## Creation of Public IP address for use by Test VM
# resource "azurerm_public_ip" "iac_public_ip" {
#   name                = "iac-vm-public-ip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Dynamic"
# }

# resource "azurerm_network_interface_nat_rule_association" "nat_rule_association" {
#   network_interface_id    = azurerm_network_interface.nic.id
#   ip_configuration_name   = "internal"  # Ensure this matches the name used in your NIC's ip_configuration block
#   nat_rule_id             = var.nat_rule_id  # Pass this variable from your module or root configuration
# }