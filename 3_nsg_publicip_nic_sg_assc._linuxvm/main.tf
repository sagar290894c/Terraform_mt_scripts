# steps => resgrp-vnet-subnet, nsg, publicip, nic, nic-sg-assc., LVM
resource "azurerm_resource_group" "waste_resgrp" {
  name     = "resgrp"
  location = "East US"
}

resource "azurerm_virtual_network" "waste_vnet9044" {
  name                = "vnet9044"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  depends_on = [ azurerm_resource_group.waste_resgrp ]
}

resource "azurerm_subnet" "waste_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.waste_resgrp.name
  virtual_network_name = azurerm_virtual_network.waste_vnet9044.name
  address_prefixes      = ["10.0.2.0/24"]
  depends_on = [ azurerm_virtual_network.waste_vnet9044 ]
}

resource "azurerm_network_security_group" "waste_nsg" {
  name                = "nsg9044"
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  location            = azurerm_resource_group.waste_resgrp.location

  security_rule {
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
}

resource "azurerm_public_ip" "waste_ip" {
  name                = "ip9044"
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  allocation_method   = "Static"
  depends_on = [ azurerm_resource_group.waste_resgrp ]
}

# Dynamic means "An IP is automatically assigned during creation of this Network Interface"; 
# Static means "User supplied IP address will be used"

resource "azurerm_network_interface" "waste_nic" {
  name                = "nic9044"
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name

  ip_configuration {
    name                          = "ipconfiguration9044"
    subnet_id                     = azurerm_subnet.waste_subnet1.id
    private_ip_address_allocation = "Dynamic"                             # see above for why Dynamic and Static
    public_ip_address_id          = azurerm_public_ip.waste_ip.id
  }
  depends_on = [ azurerm_public_ip.waste_ip ]
}

resource "azurerm_network_interface_security_group_association" "webnic_nsg_assc" {
  network_interface_id      = azurerm_network_interface.waste_nic.id
  network_security_group_id = azurerm_network_security_group.waste_nsg.id

  depends_on = [
    azurerm_network_interface.waste_nic
  ]
}

resource "azurerm_linux_virtual_machine" "waste_lvm" {
  name                = "computername1"
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  size                = "Standard_B1s"

  admin_username = "sagar290894c"
  admin_password = "Bingo9044..."

  network_interface_ids = [azurerm_network_interface.waste_nic.id]

  os_disk {
    name              = "osdisk9044"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "computer9044"
  admin_ssh_key {
    username       = "sagar290894c"
    public_key     = file("~/.ssh/id_rsa.pub")                         # linux vm path for storing key and
  }                                                                    # the same key shouid exists in my lapi
  depends_on = [ azurerm_network_interface.waste_nic ]
}
# ssh -i C:\Users\SAGAR\.ssh\id_rsa sagar290894c@_ _ _ _ _