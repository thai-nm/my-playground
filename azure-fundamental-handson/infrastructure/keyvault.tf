resource "azurerm_key_vault" "afh" {
  name                = "afh-kv"
  location            = azurerm_resource_group.afh.location
  resource_group_name = azurerm_resource_group.afh.name
  tenant_id           = local.tenant_id
  sku_name            = "standard"

  #   access_policy {
  #     tenant_id = data.azurerm_client_config.current.tenant_id
  #     object_id = data.azurerm_client_config.current.object_id

  #     key_permissions = [
  #       "Get",
  #     ]

  #     secret_permissions = [
  #       "Get",
  #     ]

  #     storage_permissions = [
  #       "Get",
  #     ]
  #   }
}