
resource "azurerm_resource_group" "rgrp" {
  name     = "rg19"
  location = "West Europe"
}

variable "v_net" {}
variable "sub_net" {}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.v_net
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers



  dynamic "subnet" {
    for_each = var.sub_net
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
}



  