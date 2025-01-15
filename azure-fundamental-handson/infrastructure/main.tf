locals {
  project = "afh"
}


resource "azurerm_resource_group" "afh" {
  name     = local.project
  location = "Southeast Asia"
}
