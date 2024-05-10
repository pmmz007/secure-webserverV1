// Authentication to Azure 
variable "client_id" {
  type        = string
  description = "define client id"
  sensitive = true
}

variable "client_secret" {
  type        = string
  description = "define client secret"
  sensitive = true
}

variable "subscription_id" {
  type        = string
  description = "define subscription id"
  sensitive = true
}

variable "tenant_id" {
  type        = string
  description = "define tenant id"
  sensitive = true
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
  type = string
  description = "define your deployment environment"
  default = "development"
}

// Virtual Network
variable "use_for_each" {
  type = bool
  description = "number of network address"
  default = true
}

variable "vnet_location" {
  type = string
  description = "define the location of your virtual network"
  default = "Southeast Asia"
}

variable "address_prefixes" {
  type = list(string)
  description = "define your network address"
  default = [ "172.16.0.0/16" ]
}

variable "vnet_name" {
  type = string
  description = "define the name of your virtual network"
  default = "secure-web-vnet"
}

variable "subnet_names" {
  type = list(string)
  description = "define your subnets name in here"
  default = [ "web-subnet", "database-subnet" ]
}

variable "subnet_prefixes" {
  type = list(string)
  description = "define subnet addresses in here"
  default = [ "172.16.1.0/24",
  "172.16.2.0/24" ]
}
