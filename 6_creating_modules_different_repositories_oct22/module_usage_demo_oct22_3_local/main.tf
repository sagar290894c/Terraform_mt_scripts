# This is local path not github or gitlab, 
# so arrange in this modulefolder containing modules (modules means without containing provider.tf and dev.tfvars)
module "myvnet" {
    source = "./modules/"
    resourcegroup_details = {
      location = "eastus"
      name = "resgrp1"
    }
    vnet_details = {
      address_space = [ "10.10.0.0/16" ]
      name = "vnet90441"
    }
    subnet_details = {
        names = [ "web", "db" ]
    }

}

output "subnetcountfrommodule" {
    value = module.myvnet.subnetcount
}

# cmd => terraform init , terraform apply -auto-approve 