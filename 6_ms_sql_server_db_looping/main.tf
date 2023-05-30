resource "azurerm_resource_group" "resource_group" {
    name                   = var.resourcegroup_details.name
    location               = var.resourcegroup_details.location
}

resource "azurerm_virtual_network" "resource_group_vnet" {
    name                    = var.vnet_details.name
    location                = var.resourcegroup_details.location
    resource_group_name     = var.resourcegroup_details.name
    address_space           = var.vnet_details.address_space
    depends_on              = [
      azurerm_resource_group.resource_group
    ]
  
}

resource "azurerm_subnet" "waste_subnet" {
    count                    = length(var.subnet_details.names)
    name                     = var.subnet_details.names[count.index]
    virtual_network_name     = var.vnet_details.name
    resource_group_name      = var.resourcegroup_details.name
    address_prefixes         = [ cidrsubnet(var.vnet_details.address_space[0],8,count.index) ]
    depends_on               = [
      azurerm_resource_group.resource_group,
      azurerm_virtual_network.resource_group_vnet
    ]
  
}

resource "azurerm_mssql_server" "waste_mssqlserver" {
  count                         = length(var.mssqlserver_details.names)
  name                          = var.mssqlserver_details.names[count.index]
  version                       = var.mssqlserver_details.version
  resource_group_name           = var.resourcegroup_details.name
  location                      = var.resourcegroup_details.location
  
  administrator_login           = var.mssqlserver_details.administrator_login
  administrator_login_password  = var.mssqlserver_details.administrator_login_password
  minimum_tls_version           = var.mssqlserver_details.minimum_tls_version                # optional
  public_network_access_enabled = true                                                       # optional
  depends_on                    = [ azurerm_subnet.waste_subnet ]
}

resource "azurerm_mssql_database" "waste_mssqldb" {
  count                         = length(var.mssqldb_details.names)
  name                          = var.mssqldb_details.names[count.index] 
  server_id                     = azurerm_mssql_server.waste_mssqlserver[count.index].id
  sku_name                      = var.mssqldb_details.sku_name
  sample_name                   = var.mssqldb_details.sample_name                             # optional
  depends_on                    = [ azurerm_mssql_server.waste_mssqlserver ]
}