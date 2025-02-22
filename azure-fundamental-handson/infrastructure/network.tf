# Virtual Network
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

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.afh.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "delegated-flexible-server-postgresql" {
  name                 = "${local.project}-delegated-subnet-flexible-server-postgresql"
  resource_group_name  = azurerm_resource_group.afh.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Network Security Group
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

# Load Balancer
resource "azurerm_public_ip" "feedback-app" {
  name                = "FeedbackAppPublicIP"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "public" {
  name                = "FeedbackApp"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name

  frontend_ip_configuration {
    name                 = "FeedbackAppPublicIP"
    public_ip_address_id = azurerm_public_ip.feedback-app.id
  }
}

resource "azurerm_lb_backend_address_pool" "feedback-app" {
  loadbalancer_id = azurerm_lb.public.id
  name            = "FeedbackAppBackendPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "feedback-app" {
  network_interface_id    = azurerm_network_interface.feedback-app.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.feedback-app.id
}

resource "azurerm_lb_probe" "feedback-app" {
  loadbalancer_id = azurerm_lb.public.id
  name            = "http-running-probe"
  port            = 80
}

resource "azurerm_lb_rule" "feedback-app" {
  loadbalancer_id                = azurerm_lb.public.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "FeedbackAppPublicIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.feedback-app.id]
  probe_id                       = azurerm_lb_probe.feedback-app.id
}


# Private DNS Zone
resource "azurerm_private_dns_zone" "flexible-server-postgresql" {
  name                = "afh.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.afh.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "flexible-server-postgresql" {
  name                  = azurerm_virtual_network.vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.flexible-server-postgresql.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.afh.name
  depends_on            = [azurerm_subnet.delegated-flexible-server-postgresql]
}