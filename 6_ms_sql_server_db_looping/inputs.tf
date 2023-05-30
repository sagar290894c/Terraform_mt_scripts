variable "resourcegroup_details" {
    type = object({
        name = string
        location = string
    })
  
}

variable "vnet_details" {
    type = object({
        name = string
        address_space = list(string)
    })
  
}

variable "subnet_details" {
    type = object({
        names = list(string)
    })
  
}

variable "mssqlserver_details" {
    type = object({
        names = list(string)
        version = string
        administrator_login = string
        administrator_login_password = string
        minimum_tls_version = string
    })
}

variable "mssqldb_details" {
    type = object({
        names = list(string)
        sku_name = string
        sample_name = string
    })
}