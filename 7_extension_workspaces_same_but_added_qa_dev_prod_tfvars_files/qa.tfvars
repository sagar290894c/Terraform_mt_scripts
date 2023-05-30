# Process: cmd => terraform workspace new qa , terraform workspace list , shows qa env. which created, 
# add the qa.tfvars file and copy contents from dev.tfvars and do any changes if you want to the configuration as 
# like the qa team and do terraform workspace select qa , terraform apply -var-file="qa.tfvars" -auto-approve

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