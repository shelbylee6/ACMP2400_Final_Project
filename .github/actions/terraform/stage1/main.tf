terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-acmp-final"
    storage_account_name = "acmp2400storageaccount"
    container_name = "big-tf-state-amcp2400"
    use_azread_auth = true
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_container_registry" "student-acr" {
  name = "acrshelbylee"
  resource_group_name = "rg-shelbylee"
  location = "Central US"
  sku = "Basic"
  admin_enabled = false
}
