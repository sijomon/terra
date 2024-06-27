variable "vnet_name" {
  description = "Name of the virtual network"
}

variable "address_space" {
  description = "Address space of the virtual network"
}

variable "location" {
  description = "Location/region of the virtual network"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}
variable "availability_zones" {
  type    = list(string)
  default = ["1", "2", "3"]  # Example: List of Availability Zones
}