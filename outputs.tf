output "resource_group_id" {
    value = azurerm_resource_group.lab.id
}
output "resource_group_name" {
    value = azurerm_resource_group.lab.name
}

// virtual network
output "name_of_vnet" {
    value = module.secure-web-vnet.vnet_name
}

output "id_of_vnet" {
    value = module.secure-web-vnet.vnet_id
}

output "network_prefixes_of_vnet" {
    value = module.secure-web-vnet.vnet_address_space
}

output "web-subnet-name_id" {
    value = module.secure-web-vnet.vnet_subnets[0]
}