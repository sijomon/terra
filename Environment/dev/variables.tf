
# Define variables
variable "location" {
  description = "Location/region of the resources"
  default     = "Jio India West "
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "InWdistrg01"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  default     = "InWdistvnet01"
}