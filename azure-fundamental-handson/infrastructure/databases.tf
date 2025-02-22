

resource "azurerm_postgresql_flexible_server" "example" {
  name                          = "afh-postgresql"
  resource_group_name           = azurerm_resource_group.afh.name
  location                      = azurerm_resource_group.afh.location
  version                       = "16"
  delegated_subnet_id           = azurerm_subnet.delegated-flexible-server-postgresql.id
  private_dns_zone_id           = azurerm_private_dns_zone.flexible-server-postgresql.id
  public_network_access_enabled = false
  administrator_login           = "dbadmin"
  administrator_password        = "dbadmin@25879"
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.flexible-server-postgresql]

}