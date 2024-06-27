# terraform settings block
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.101.0"
    }
  }
}


# Configure Azure provider
provider "azurerm" {
  features {}
}


# Instantiate resource group module
module "resource_group" {
  source              = "../../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Instantiate VNet module
module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Define module for public IP address
/*module "public_ip" {
  source              = "Azure/compute/azurerm"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  vnet_subnet_id      = module.subnets["public"].subnet_id
}*/

resource "azurerm_public_ip" "pip" {
 
  allocation_method   = "Static"
  location            = var.location
  name                = "pip"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

# Define subnet configurations
locals {

 
  subnets = {
    public = {
      name             = "subnet-public"
      address_prefixes = ["10.0.1.0/24"]
      availability_zone = "1"
      nsg_id           = null  # Optional: Provide NSG ID
      route_table_id   = null  # Optional: Provide route table ID
      nat_gateway_enabled  = false
      public_ip_address_id = null  # Optional: Provide public IP address ID for NAT
      //public_ip_address_id = azurerm_public_ip.pip.public_ip_address_id
    }
    private_nat = {
      name             = "subnet-private-nat"
      address_prefixes = ["10.0.2.0/24"]
      availability_zone = "2"
      nsg_id           = null  # Optional: Provide NSG ID
      route_table_id   = null  # Optional: Provide route table ID
      nat_gateway_enabled  = true
      #public_ip_address_id = module.public_ip.nat_public_ip_id  # Provide the ID of the public IP for NAT
      public_ip_address_id = azurerm_public_ip.pip.id
    }
    private_no_nat = {
      name             = "subnet-private-no-nat"
      address_prefixes = ["10.0.3.0/24"]
      availability_zone = "3"
      nsg_id           = null  # Optional: Provide NSG ID
      route_table_id   = null  # Optional: Provide route table ID
      nat_gateway_enabled  = false
      public_ip_address_id = null  # Optional: Provide public IP address ID for NAT
    }
  }
}



# Instantiate subnet modules
module "subnets" {
  source  = "../../modules/subnet"
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  vnet_name            = var.vnet_name
  address_prefixes     = each.value.address_prefixes
  availability_zones   = each.value.availability_zones[0]
  nsg_id               = each.value.nsg_id
  route_table_id       = each.value.route_table_id
  nat_gateway_enabled  = each.value.nat_gateway_enabled
  public_ip_address_id = each.value.public_ip_address_id
}

# Output subnet IDs if needed
output "public_subnet_id" {
  value = module.subnets["public"].subnet_id
}

output "private_subnet_nat_id" {
  value = module.subnets["private_nat"].subnet_id
}

output "private_subnet_no_nat_id" {
  value = module.subnets["private_no_nat"].subnet_id
}
