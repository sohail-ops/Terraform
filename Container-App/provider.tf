terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=4.34.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}