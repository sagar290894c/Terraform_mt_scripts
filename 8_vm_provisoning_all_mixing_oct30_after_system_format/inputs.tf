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

variable "runningversion" {
    type = string
    default = "1.0"

}