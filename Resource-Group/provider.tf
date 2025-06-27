terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.34.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Terraform-POC"
    storage_account_name = "i2dstgacc"
    container_name       = "terraform"
    key                  = "tf/terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
