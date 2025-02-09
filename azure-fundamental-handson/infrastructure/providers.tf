terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "misc"
      storage_account_name = "thainmtfstate"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
      use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}
