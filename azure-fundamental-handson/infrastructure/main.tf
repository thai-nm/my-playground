locals {
  project            = "afh"
  location           = "West US"
  tenant_id          = "45b43356-230b-4fea-8f35-2453f8961d3b"
  cloudflare_zone_id = "ae3afeae2c316d39789d08c3bf022c28"

  owner_principle = {
    name      = "thainguyen"
    object_id = "85e87048-cd8c-4b12-8b1b-4da354198521"
  }
}

resource "azurerm_resource_group" "afh" {
  name     = local.project
  location = local.location
}
