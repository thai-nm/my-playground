resource "azurerm_key_vault" "afh" {
  name                = "afh-kv"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name
  tenant_id           = local.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = local.tenant_id
    object_id = local.owner_principle.object_id

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set"
    ]
  }
}