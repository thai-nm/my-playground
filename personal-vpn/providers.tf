terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }

  }
  backend "azurerm" {
    resource_group_name  = "misc"
    storage_account_name = "thainmtfstate"
    container_name       = "tfstate"
    key                  = "terraform-pvpn.tfstate"
  }
}

provider "azurerm" {
  features {}
}
