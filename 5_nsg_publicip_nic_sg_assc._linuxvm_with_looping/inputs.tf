variable "resourcegroup_details" {
    type = object({
        name=string
        location=string
    })
  
}

variable "vnet_details" {
    type = object({
        name=string
        address_space=list(string)
    })
  
}

variable "subnet_details" {
    type = object({
        names=list(string)
    })
  
}

variable "vm_details" {
  type = object({
    names = list(string)
    size = string
    admin_username = string
    admin_password = string
    storage_account_type = string
    publisher = string
    offer = string
    sku = string
    version = string
    computer_name = string
  })
}

variable "ssh_details" {
  type = object({
    username = string
    public_key = string
  })
}

variable "nsg_details" {
  type = object({
    names = list(string)
  })
  
}

variable "securityrule_details" {
  type = object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  })
}

variable "publicip_details" {
  type = object({
    names = list(string)
    allocation_method = string
  })
}

variable "nic_details" {
  type = object({
    names = list(string)
  })
}

variable "ipconfiguration_details" {
  type = object({
    name = string
    private_ip_address_allocation = string
  })
}