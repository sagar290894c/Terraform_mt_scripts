# general steps to follow for creating VM => resgrp-vnet-subnet, nsg, publicip, nic, nic-sg-assc., LVM
resource "azurerm_linux_virtual_machine" "waste_webvm" {
  resource_group_name = var.resourcegroup_details.name
  location            = var.resourcegroup_details.location
  name = format("webvm-%s",terraform.workspace)
  size = "Standard_B1s"
  admin_username = "sagar290894c"
  admin_password = "Bingo9044..."
  network_interface_ids = [
    azurerm_network_interface.waste_webnic.id
  ]
  disable_password_authentication = false              # i think we cannot connect by ssh to this vm once check ok
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

}

resource "null_resource" "cluster" {
  triggers = {
    version = var.runningversion              # for null resource add running version in inputs.tf , dev.tfvars
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"           # open Browser with PublicIp:80 check it for nginx server installed or not
    ]

    connection {
     host = azurerm_linux_virtual_machine.waste_webvm.public_ip_address
     user = "sagar290894c"
     password = "Bingo9044..."

    }
  }
  depends_on = [
    azurerm_linux_virtual_machine.waste_webvm
  ]
}