resource "azurerm_storage_account" "afh" {
  name                     = local.project
  resource_group_name      = azurerm_resource_group.afh.name
  location                 = azurerm_resource_group.afh.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Allow blob public access
  allow_nested_items_to_be_public = true
  https_traffic_only_enabled      = false
}

resource "azurerm_storage_account_static_website" "afh" {
  storage_account_id = azurerm_storage_account.afh.id
  error_404_document = "error.html"
  index_document     = "index.html"
}
