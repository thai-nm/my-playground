locals {
  project   = "personal-vpn"
  location  = "Southeast Asia"
  tenant_id = "45b43356-230b-4fea-8f35-2453f8961d3b"

  # owner_principle = {
  #   name      = "thainguyen"
  #   object_id = "85e87048-cd8c-4b12-8b1b-4da354198521"
  # }
}

resource "azurerm_resource_group" "psnvpn" {
  name     = local.project
  location = local.location
}
