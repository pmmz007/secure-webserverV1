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
