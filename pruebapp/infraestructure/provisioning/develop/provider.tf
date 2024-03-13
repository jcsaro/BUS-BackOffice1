terraform {
  required_version = "1.7.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.91.0"
    }
  }

}

provider "azurerm" {
  features {}
}