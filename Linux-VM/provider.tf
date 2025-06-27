terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.21.1"
    }

    azapi = {
      source  = "Azure/azapi"
      version = ">=2.2.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  features {
    virtual_machine {
      skip_shutdown_and_force_delete        = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}