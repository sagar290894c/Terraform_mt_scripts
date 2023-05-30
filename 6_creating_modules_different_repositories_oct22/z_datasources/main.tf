# Datasources used to fetch informaton of about what resources are present in our cloud provider like 
# azure or aws or (both of azure and aws) in my accounts by using terraform lists the resources present like vnet
# subnets, storage accounts, linux vm's ,...    => cmd's => terraform init  , terraform apply -auto-approve
# cmd's are => terraform init  , terraform apply -auto-approve

data "azurerm_resources" "allresources" {
    type = "Microsoft.Network/virtualNetworks"
}

output "vnets-count" {
    value = length(data.azurerm_resources.allresources.resources)
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "subnetids" {
    filter {
      name = "availability-zone"
      values = [ "ap-south-1a" ]
    }
}

output "defaultvpcid" {
    value = data.aws_vpc.default.id
}

output "subnetids" {
    value = data.aws_subnets.subnetids.ids
}