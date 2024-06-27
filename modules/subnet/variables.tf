variable "name" {
  description = "Name of the subnet"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "vnet_name" {
  description = "Name of the virtual network"
}

variable "address_prefixes" {
  description = "Address prefixes of the subnet"
  default     = "24"
}


variable "availability_zones" {
  type    = list(string)
  default = ["1", "2", "3"]  # Example: List of Availability Zones
}


variable "nsg_id" {
  description = "ID of the network security group to associate with the subnet"
  default     = null
}

variable "route_table_id" {
  description = "ID of the route table to associate with the subnet"
  default     = null
}

variable "nat_gateway_enabled" {
  description = "Enable NAT gateway for outbound internet access"
  default     = false
}

variable "public_ip_address_id" {
  description = "ID of the public IP address for NAT gateway"
  default     = null
}
