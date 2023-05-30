resource "azurerm_resource_group" "waste_resgrp" {
    name            =  "resgrp"
    location        = "eastus"
    tags            = {
        project     = "webapp",
        env         = "dev"
    }
  
}

resource "azurerm_storage_account" "waste_storage_account" {
    name                     = "storage9044"
    resource_group_name      = "resgrp"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags                     = {
        project              = "webapp",
        env                  = "dev"
    }
    depends_on = [ azurerm_resource_group.waste_resgrp ]
}

resource "azurerm_virtual_network" "waste_vnet" {
    name                    = "vnet9044"
    resource_group_name     = "resgrp"
    location                = "eastus"
    address_space           = [ "192.168.0.0/16" ]
    depends_on = [ azurerm_resource_group.waste_resgrp ]
  }

resource "azurerm_subnet" "waste_subnet" {
    name                   = "subnet1"
    virtual_network_name   = "vnet9044"
    resource_group_name    = "resgrp"
    address_prefixes       = [ "192.168.0.0/24" ]
    depends_on             = [ azurerm_virtual_network.waste_vnet ]
}

#  ms sql database (includes the ms sql server),  very very easy only below see
resource "azurerm_mssql_server" "waste_mssqlserver" {
  name                         = "sqlserver9044"
  resource_group_name          = "resgrp"
  location                     = "eastus"
  version                      = "12.0"
  
  administrator_login          = "sagar290894c"
  administrator_login_password = "Bingo9044..."
  minimum_tls_version          = "1.2"                         # optional write or dont write
  public_network_access_enabled = true                         # optional write or dont write
  depends_on = [ 
    azurerm_storage_account.waste_storage_account,
    azurerm_subnet.waste_subnet
   ]
}

resource "azurerm_mssql_database" "waste_mssqldb" {
  name                          = "mssqldb9044"
  server_id                     = azurerm_mssql_server.waste_mssqlserver.id
  sku_name                      = "Basic"
  sample_name                   = "AdventureWorksLT"            # optional
  depends_on = [ azurerm_mssql_server.waste_mssqlserver ]
}