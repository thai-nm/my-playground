
resource "azurerm_storage_account" "afh" {
  name                     = local.project
  resource_group_name      = azurerm_resource_group.afh.name
  location                 = azurerm_resource_group.afh.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "afh" {
  name                  = local.project
  storage_account_id    = azurerm_storage_account.afh.id
  container_access_type = "private"
}
