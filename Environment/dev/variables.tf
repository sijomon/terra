
# Define variables
variable "location" {
  description = "Location/region of the resources"
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rgsijo"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  default     = "vnetsijo"
}