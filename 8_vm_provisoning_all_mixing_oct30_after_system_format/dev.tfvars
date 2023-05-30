resourcegroup_details = {
  name ="res_grp1"
  location ="eastus"
}

vnet_details = {
  address_space = [ "192.168.0.0/16" ]
  name = "vnet9044"
}

subnet_details = {
  names = [ "web", "app", "cache", "mgmt", "ad", "db" ]
}

runningversion = "1.0"
# cmds => terraform init  , terraform validate , terraform apply -var-file="dev.tfvars" -auto-approve