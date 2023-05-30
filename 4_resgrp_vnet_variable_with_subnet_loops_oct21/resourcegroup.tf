resource "azurerm_resource_group" "resource_group" {
    name = var.resourcegroup_details.name
    location = var.resourcegroup_details.location
  
}