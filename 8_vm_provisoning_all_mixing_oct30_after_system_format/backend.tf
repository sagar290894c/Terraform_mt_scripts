terraform {
  backend "azurerm" {
    resource_group_name  = "res_grp"
    storage_account_name = "storage9044"
    container_name       = "container9044"
    key                  = "ntier.tfstate"
  }
}