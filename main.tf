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
    public_ip_address_id          = azurerm_public_ip.lab.id

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

// NIC & NSG association
resource "azurerm_network_interface_security_group_association" "lab" {
  network_interface_id      = azurerm_network_interface.lab.id
  network_security_group_id = azurerm_network_security_group.lab.id
}

// Public IP address
resource "azurerm_public_ip" "lab" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  allocation_method   = var.public_ip_allocation_method

  tags = {
    environment = var.environment
  }
}

// virtual machine bolck
resource "azurerm_linux_virtual_machine" "lab" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = var.vmsize
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.lab.id,
  ]
  #  custom_data = base64encode(templatefile("${path.module}/user_data.sh", {}))

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
  custom_data = base64encode(templatefile("${path.module}/user_data.sh", {}))

}

// Storage Account
resource "azurerm_storage_account" "lab" {
  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.lab.name

  location                 = azurerm_resource_group.lab.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    environment = var.environment
  }
}

// Storage Container
resource "azurerm_storage_container" "lab" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.lab.name
  container_access_type = var.container_access_type
}

// Upload Data into Container
resource "azurerm_storage_blob" "lab" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.lab.name
  storage_container_name = azurerm_storage_container.lab.name
  type                   = var.storage_blob_type
  source                 = "index.html"
}

// Custom Role Blob Read/Write
resource "azurerm_role_definition" "vnet_peering" {
  name  = var.custom_blob_role_name
  scope = "/subscriptions/9ea6c168-cf8c-47a6-a689-a7c35990bf7f"
  permissions {
    actions = ["Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/lease/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/clearLegalHold/action",
    "Microsoft.Storage/storageAccounts/blobServices/containers/setLegalHold/action"]
    not_actions = []
  }
  assignable_scopes = var.assignable_scopes
}

// Role Assignment
