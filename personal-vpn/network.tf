# = VNet and Subnets =========================================================
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.project}-vnet"
  resource_group_name = azurerm_resource_group.psnvpn.name
  location            = azurerm_resource_group.psnvpn.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "public" {
  name                 = "${local.project}-public-subnet"
  resource_group_name  = azurerm_resource_group.psnvpn.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# = Network Security Group =====================================================
resource "azurerm_network_security_group" "public" {
  name                = "public-nsg"
  location            = azurerm_resource_group.psnvpn.location
  resource_group_name = azurerm_resource_group.psnvpn.name
}

resource "azurerm_network_security_rule" "allow-inbound-public" {
  name                         = "OnlyAllowHTTPAndSSHInbound"
  priority                     = 100
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_address_prefix        = "*"
  source_port_range            = "*"
  destination_address_prefixes = azurerm_subnet.private.address_prefixes
  destination_port_ranges      = ["80", "22"]
  resource_group_name          = azurerm_resource_group.psnvpn.name
  network_security_group_name  = azurerm_network_security_group.public.name
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

# IP Addresses =================================================================
resource "azurerm_public_ip" "vpn-server" {
  name                = "VPNServerPublicIP"
  location            = azurerm_resource_group.psnvpn.location
  resource_group_name = azurerm_resource_group.psnvpn.name
  allocation_method   = "Static"
}
