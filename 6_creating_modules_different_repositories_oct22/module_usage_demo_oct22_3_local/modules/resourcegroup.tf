resource "azurerm_resource_group" "waste_resgrp" {
    name = var.resourcegroup_details.name
    location = var.resourcegroup_details.location
  
}