resourcegroup_details = {
  name ="res_grp"
  location ="eastus"
}

vnet_details = {
  address_space = [ "192.168.0.0/16" ]
  name = "vnet9044"
}

subnet_details = {
  names = [ "web" ]
}

vm_details = {
  names = [ "vm9044", "vm90441" ]
  size = "Standard_B1s"
  admin_username = "sagar290894c"
  admin_password = "Bingo9044..."
  storage_account_type = "Standard_LRS"
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts-gen2"
  version   = "latest"
  computer_name = "computer9044"
}

ssh_details = {
  username = "sagar290894c"
  public_key = "~/.ssh/id_rsa.pub"
}

nsg_details = {
  names = [ "sg1" ]
}

securityrule_details = {
  name                       = "openssh"
  priority                   = 300
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

publicip_details = {
  names = [ "ip9044", "ip90441" ]
  allocation_method = "Static"
}

nic_details = {
  names = [ "nic9044", "nic90441" ]
}

ipconfiguration_details = {
  name = "ipconfiguration9044"
  private_ip_address_allocation = "Dynamic"
}