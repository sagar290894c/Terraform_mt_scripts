resourcegroup_details = {
  name                           ="resgrp"
  location                       ="eastus"
}

vnet_details                     = {
  address_space                  = [ "192.168.0.0/16" ]
  name                           = "vnet9044"
}

subnet_details = {
  names                          = [ "web", "app", "cache", "mgmt", "ad", "db" ]
}

mssqlserver_details = {
  names                         = [ "sqlserver9044", "sqlserver90441" ]
  version                       = "12.0"
  administrator_login           = "sagar290894c"
  administrator_login_password  = "Bingo9044..."
  minimum_tls_version           = "1.2"  
}

mssqldb_details = {
  names                         = [ "mssqldb9044", "mssqldb90441" ]
  sku_name                      = "Basic"
  sample_name                   = "AdventureWorksLT"
}