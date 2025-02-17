locals {
  project            = "afh"
  location           = "West US"
  tenant_id          = "45b43356-230b-4fea-8f35-2453f8961d3b"
  cloudflare_zone_id = "ae3afeae2c316d39789d08c3bf022c28"
}

resource "azurerm_resource_group" "afh" {
  name     = local.project
  location = local.location
}
