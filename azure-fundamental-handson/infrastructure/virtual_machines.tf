resource "azurerm_bastion_host" "feedback-app" {
  name                = "feedback-app-bastion"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name

  sku                = "Developer"
  virtual_network_id = azurerm_virtual_network.vnet.id

  ip_configuration {
    name                 = "feedback-app-bastion-ip"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.feedback-app-bastion.id
  }
}

resource "azurerm_network_interface" "feedback-app" {
  name                = "feedback-app-nic"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.private.id
  }
}

resource "azurerm_linux_virtual_machine" "feedback-app" {
  name                = "feedback-app-vm"
  resource_group_name = azurerm_resource_group.afh.name
  location            = azurerm_resource_group.afh.location
  size                = "Standard_B1s"
  admin_username      = "lucas"
  network_interface_ids = [
    azurerm_network_interface.feedback-app.id,
  ]

  admin_ssh_key {
    username   = "lucas"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZN69eGNrS+mYAph2Bty3jjHvKtvrscISAoM93mc3eo"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}