# git push files without containing provider.tf and dev.tfvars to github repo 
# and specify that github link in source below thatsol
# below in source replace with your github link, but down thats sir's github link ok , any of my github repo link
module "myvnet" {
    source = "github.com/asquarezone/ntier-azure-vnet"
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
# Here modules folder not required bcoz modules are already sent ro above git link ok