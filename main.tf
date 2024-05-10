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
  use_for_each = var.use_for_each
  vnet_location = var.vnet_location
  address_space = var.address_prefixes
  vnet_name = var.vnet_name
  subnet_names = var.subnet_names
  subnet_prefixes = var.subnet_prefixes
  tags = {
    environment = var.environment
  }
  depends_on = [ azurerm_resource_group.lab ]
}