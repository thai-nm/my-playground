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

resource "azurerm_network_security_group" "private" {
  name                = "private-nsg"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name
}

resource "azurerm_network_security_rule" "only-allow-http-inbound" {
  name                         = "OnlyAllowHttpInbound"
  priority                     = 100
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "80"
  source_address_prefix        = "*"
  destination_address_prefixes = azurerm_subnet.private.address_prefixes
  resource_group_name          = azurerm_resource_group.afh.name
  network_security_group_name  = azurerm_network_security_group.private.name
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}

# resource "azurerm_public_ip" "feedback-app" {
#   name                = "FeedbackAppPublicIP"
#   location            = azurerm_resource_group.afh.location
#   resource_group_name = azurerm_resource_group.afh.name
#   allocation_method   = "Static"
# }

# resource "azurerm_lb" "public" {
#   name                = "FeedbackApp"
#   location            = azurerm_resource_group.afh.location
#   resource_group_name = azurerm_resource_group.afh.name

#   frontend_ip_configuration {
#     name                 = "FeedbackAppPublicIP"
#     public_ip_address_id = azurerm_public_ip.feedback-app.id
#   }
# }