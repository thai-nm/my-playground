resource "azurerm_virtual_network" "vnet" {
  name                = "${local.project}-vnet"
  resource_group_name = azurerm_resource_group.afh.name
  location            = azurerm_resource_group.afh.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "public" {
  name                 = "${local.project}-public-subnet"
  resource_group_name  = azurerm_resource_group.afh.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private" {
  name                 = "${local.project}-private-subnet" 
  resource_group_name  = azurerm_resource_group.afh.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
