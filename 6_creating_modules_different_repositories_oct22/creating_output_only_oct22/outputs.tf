output "resourcegroup_name" {
    value = azurerm_resource_group.waste_resgrp.name      # from resourcegroup.tf of ""
}

output "location" {
    value = azurerm_resource_group.waste_resgrp.location   # same from resourcegroup.tf of ""
}

output "vnetid" {
    value = azurerm_virtual_network.waste_vnet.id    
}

output "vnetname" {
    value = azurerm_virtual_network.waste_vnet.name    # from network.tf of ""

}
output "subnets" { 
    value = azurerm_subnet.waste_subnet

}
# extra below sir told just in case to check length of subnets ok
output "subnetcount" {
    value = length(azurerm_subnet.waste_subnet)
}