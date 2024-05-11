// Authentication to Azure 
variable "client_id" {
  type        = string
  description = "define client id"
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "define client secret"
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "define subscription id"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "define tenant id"
  sensitive   = true
}

// Resource Group
variable "resource_group_name" {
  type        = string
  description = "define resource group name"
  default     = "WebserverRG"
}

variable "location" {
  type        = string
  description = "define location of resources"
  default     = "Southeast Asia"
}

variable "environment" {
  type        = string
  description = "define your deployment environment"
  default     = "development"
}

// Virtual Network
variable "use_for_each" {
  type        = bool
  description = "number of network address"
  default     = true
}

variable "vnet_location" {
  type        = string
  description = "define the location of your virtual network"
  default     = "Southeast Asia"
}

variable "address_prefixes" {
  type        = list(string)
  description = "define your network address"
  default     = ["172.16.0.0/16"]
}

variable "vnet_name" {
  type        = string
  description = "define the name of your virtual network"
  default     = "secure-web-vnet"
}

variable "subnet_names" {
  type        = list(string)
  description = "define your subnets name in here"
  default     = ["web-subnet", "database-subnet"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "define subnet addresses in here"
  default = ["172.16.1.0/24",
  "172.16.2.0/24"]
}

// Virtual Machine
// Network Interface
variable "vm_nic_name" {
  type        = string
  description = "define network interface name"
  default     = "secure-web-nic"
}

variable "internal_nic_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "webserver-internal"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Dynamic"
}

// Network Security Group

variable "webserver_nsg_name" {
  type        = string
  description = "define name of network security group for web server"
  default     = "webserverNSG"
}

variable "nsg_rule_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "allowssh"
}

variable "rule_priority" {
  type        = string
  description = "(optional) describe your variable"
  default     = "100"
}

variable "direction" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Inbound"
}

variable "access" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Allow"
}

variable "protocol" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Tcp"
}

// Public ip address
variable "public_ip_name" {
  type        = string
  description = "define name of public ip adddress"
  default     = "secure-webserver-pip"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "define public ip allocation method"
  default     = "Static"
}

// Virtual Machine
variable "vm_name" {
  type        = string
  description = "define name of your virtual machine"
  default     = "secure-webserver"
}

variable "vmsize" {
  type        = string
  description = "define virtual machine size"
  default     = "Standard_F2"
}

variable "admin_username" {
  type        = string
  description = "define admin user name"
  default     = "johnie"
}

variable "caching" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ReadWrite"
}

variable "storage_account_type" {
  type        = string
  description = "define your storage account type"
  default     = "Standard_LRS"
}

variable "publisher" {
  type        = string
  description = "(optional) describe your variable"
  default     = "Canonical"
}

variable "offer" {
  type        = string
  description = "(optional) describe your variable"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "sku" {
  type        = string
  description = "define OS Version"
  default     = "22_04-lts"
}

variable "os_version" {
  type        = string
  description = "(optional) describe your variable"
  default     = "latest"
}

// storage account

variable "storage_account_name" {
  type    = string
  default = "stg8demo"
}

variable "account_tier" {
  type        = string
  description = "define account tier type"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "define storage account replication type"
  default     = "LRS"
}

// Storage Container

variable "storage_container_name" {
  type        = string
  description = "define the name of the container in storage account"
  default     = "mydemoctl"
}

variable "container_access_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "private"
}

variable "storage_blob_type" {
  type = string
  description = "(optional) describe your variable"
  default = "Block"
}

// Custom Role Definition

variable "custom_blob_role_name" {
  type = string
  description = "(optional) describe your variable"
  default = "Cblob-pmmz"
}

variable "lab_uami" {
  type = string
  description = "(optional) describe your variable"
  default = "tostorageuami"
}




