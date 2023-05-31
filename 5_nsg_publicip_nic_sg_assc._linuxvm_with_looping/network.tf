resource "azurerm_resource_group" "waste_resgrp" {
    name = var.resourcegroup_details.name
    location = var.resourcegroup_details.location
  }

resource "azurerm_virtual_network" "waste_vnet" {
    name = var.vnet_details.name
    location = var.resourcegroup_details.location
    resource_group_name = var.resourcegroup_details.name
    address_space = var.vnet_details.address_space
    depends_on = [
      azurerm_resource_group.waste_resgrp
    ]
  
}

resource "azurerm_subnet" "waste_subnet" {
    count = length(var.subnet_details.names)
    name = var.subnet_details.names[count.index]
    virtual_network_name = var.vnet_details.name
    resource_group_name = var.resourcegroup_details.name
    address_prefixes = [ cidrsubnet(var.vnet_details.address_space[0],8,count.index) ]
    depends_on = [
      azurerm_virtual_network.waste_vnet
    ]
  
}

resource "azurerm_linux_virtual_machine" "waste_lvm" {
  count               = length(var.vm_details.names)
  name                = var.vm_details.names[count.index]
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  size                = var.vm_details.size

  admin_username = var.vm_details.admin_username

  network_interface_ids = [azurerm_network_interface.waste_nic[count.index].id]
    
  admin_ssh_key {
    username       = var.ssh_details.username
    public_key     = file(var.ssh_details.public_key)
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = var.vm_details.storage_account_type
  }

  source_image_reference {
    publisher = var.vm_details.publisher
    offer     = var.vm_details.offer
    sku       = var.vm_details.sku
    version   = var.vm_details.version
  }

  computer_name = var.vm_details.computer_name
  depends_on = [ azurerm_network_interface.waste_nic ]
}

resource "azurerm_network_security_group" "waste_nsg" {
  count               = length(var.nsg_details.names)
  name                = var.nsg_details.names[count.index]
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  location            = azurerm_resource_group.waste_resgrp.location

  security_rule {
    name                       = var.securityrule_details.name
    priority                   = var.securityrule_details.priority
    direction                  = var.securityrule_details.direction
    access                     = var.securityrule_details.access
    protocol                   = var.securityrule_details.protocol
    source_port_range          = var.securityrule_details.source_port_range
    destination_port_range     = var.securityrule_details.destination_port_range
    source_address_prefix      = var.securityrule_details.source_address_prefix
    destination_address_prefix = var.securityrule_details.destination_address_prefix
  }
}

resource "azurerm_public_ip" "waste_ip" {
  count               = length(var.publicip_details.names)
  name                = var.publicip_details.names[count.index]
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name
  allocation_method   = var.publicip_details.allocation_method
  depends_on = [ azurerm_resource_group.waste_resgrp ]
}

resource "azurerm_network_interface" "waste_nic" {
  count               = length(var.nic_details.names)
  name                = var.nic_details.names[count.index]
  location            = azurerm_resource_group.waste_resgrp.location
  resource_group_name = azurerm_resource_group.waste_resgrp.name

  ip_configuration {
    name                          = var.ipconfiguration_details.name
    subnet_id                     = azurerm_subnet.waste_subnet[0].id
    private_ip_address_allocation = var.ipconfiguration_details.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.waste_ip[count.index].id
  }
  depends_on = [ 
    azurerm_public_ip.waste_ip
   ]
}

resource "azurerm_network_interface_security_group_association" "webnic_nsg_assc" {
  network_interface_id      = azurerm_network_interface.waste_nic[0].id
  network_security_group_id = azurerm_network_security_group.waste_nsg[0].id

  depends_on = [
    azurerm_network_interface.waste_nic
  ]
}
