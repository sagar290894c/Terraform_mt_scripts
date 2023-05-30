# git push files without containing provider.tf and dev.tfvars to github any repo 
# below in source replace with your github link, but down thats sir's github link
module "myvnet" {
    source = "github.com/asquarezone/ntier-azure-vnet"
    resourcegroup_details = {
      location = "eastus"
      name = "resgrp1"
    }
    vnet_details = {
      address_space = [ "192.168.0.0/16" ]
      name = "vnet90441"
    }
    subnet_details = {
        names = [ "web", "db", "cache", "mgmt" ]
    }

}

output "subnetcountfrommodule" {
    value = module.myvnet.subnetcount
}

# cmd => terraform init , terraform apply -auto-approve 