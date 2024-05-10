// Resource Group
resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
  }
}

// Virtual Network
module "secure-web-vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  # insert the 3 required variables here
  resource_group_name = var.resource_group_name
  use_for_each        = var.use_for_each
  vnet_location       = var.vnet_location
  address_space       = var.address_prefixes
  vnet_name           = var.vnet_name
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_prefixes
  tags = {
    environment = var.environment
  }
  depends_on = [azurerm_resource_group.lab]
}

// Virtual Machine
// Network Interface
resource "azurerm_network_interface" "lab" {
  name                = var.vm_nic_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = var.internal_nic_name
    subnet_id                     = module.secure-web-vnet.vnet_subnets[1]
    private_ip_address_allocation = var.private_ip_address_allocation

  }
}

// Network Security Group
resource "azurerm_network_security_group" "lab" {
  name                = var.webserver_nsg_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = var.nsg_rule_name
    priority                   = var.rule_priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}
