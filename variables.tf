// Authentication to Azure 
variable "client_id" {
  type        = string
  description = "define client id"
}

variable "client_secret" {
  type        = string
  description = "define client secret"
}

variable "subscription_id" {
  type        = string
  description = "define subscription id"
}

variable "tenant_id" {
  type        = string
  description = "define tenant id"
}

// Resource Group
variable "resource_group_name" {
  type        = string
  description = "define resource group name"
  default = "WebserverRG"
}

variable "location" {
    type = string
    description = "define location of resources"
    default = "Southeast Asia"
}
