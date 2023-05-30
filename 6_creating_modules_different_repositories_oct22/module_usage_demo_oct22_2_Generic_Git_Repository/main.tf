# difference between github/gitlab/anygitlinks and GenericGit is infront of links just add  git:: thatsol see below
module "myvnet" {
    source = "git::https://github.com/asquarezone/ntier-azure-vnet.git"
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