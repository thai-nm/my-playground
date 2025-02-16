locals {
  project            = "afh"
  location           = "Southeast Asia"
  cloudflare_zone_id = "ae3afeae2c316d39789d08c3bf022c28"
}

resource "azurerm_resource_group" "afh" {
  name     = local.project
  location = local.location
}
