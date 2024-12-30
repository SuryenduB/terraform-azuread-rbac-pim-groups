provider "azuread" {

}

terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-entra-license-management"
    storage_account_name = "globstlicensemanagement"
    container_name       = "pagstate"
    key                  = "pag.tfstate"
  }

}