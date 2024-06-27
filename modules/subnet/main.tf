resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
  #availability_zones   = var.availability_zones

  # Optional: Associate NSG
 //network_security_group_id = var.nsg_id if var.nsg_id != null else null
 // network_security_group_id = var.nsg_id != null ? var.nsg_id : null

  

  # Optional: Associate route table
  //route_table_id = var.route_table_id if var.route_table_id != null else null

  //route_table_id = var.route_table_id != null ? var.route_table_id : null

  # Optional: Define NAT gateway for private subnets with NAT
  /*dynamic "nat_gateway" {
    for_each = var.nat_gateway_enabled ? [1] : []
    content {
      name            = "${var.name}-nat-gateway"
      public_ip_address_id = var.public_ip_address_id
    }
  }*/
}
