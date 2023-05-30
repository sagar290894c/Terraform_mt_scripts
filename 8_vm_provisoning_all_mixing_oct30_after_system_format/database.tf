resource "azurerm_mssql_server" "waste_mssqlserver" {
    name = format("mssqlserver9044%s",terraform.workspace)
    resource_group_name = var.resourcegroup_details.name
    location = var.resourcegroup_details.location
    version = "12.0"
    administrator_login          = "sagar290894c"
    administrator_login_password = "Bingo9044..."
    minimum_tls_version          = "1.2"
    public_network_access_enabled = true
    depends_on = [
      azurerm_resource_group.waste_resgrp,
      azurerm_virtual_network.waste_vnet,
      azurerm_subnet.waste_subnet
    ]
}

resource "azurerm_mssql_database" "mssqldb" {
    name = format("mssqldb9044%s", terraform.workspace)
    server_id = azurerm_mssql_server.waste_mssqlserver.id
    sample_name = "AdventureWorksLT"
    sku_name = "Basic"
    tags = {
      Env = terraform.workspace
    }
    depends_on = [
      azurerm_mssql_server.waste_mssqlserver
    ]
}