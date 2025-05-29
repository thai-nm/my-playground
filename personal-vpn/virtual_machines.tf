resource "azurerm_network_interface" "vpn-server" {
  name                = "vpn-server-nic"
  location            = azurerm_resource_group.psnvpn.location
  resource_group_name = azurerm_resource_group.psnvpn.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vpn-server.id
  }
}

resource "azurerm_linux_virtual_machine" "vpn-server" {
  name                = "personal-vpn-server"
  resource_group_name = azurerm_resource_group.psnvpn.name
  location            = azurerm_resource_group.psnvpn.location
  size                = "Standard_B1s"
  admin_username      = "lucas"
  network_interface_ids = [
    azurerm_network_interface.vpn-server.id,
  ]

  admin_ssh_key {
    username   = "lucas"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZN69eGNrS+mYAph2Bty3jjHvKtvrscISAoM93mc3eo"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server-gen1"
    version   = "latest"
  }
}
