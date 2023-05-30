resourcegroup_details = {
  name ="resource_group_rg"
  location ="eastus"
}

vnet_details = {
  address_space = [ "192.168.0.0/16" ]
  name = "resource_group_vnet"
}

subnet_details = {
  names = [ "web", "app", "cache", "mgmt", "ad", "db" ]
}