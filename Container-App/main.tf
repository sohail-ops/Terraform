# Resource Group
resource "azurerm_resource_group" "rg_main" {
  name     = "rg_i2d_poc"
  location = "westus2"
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "poc-law"
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Container App Environment
resource "azurerm_container_app_environment" "app_env" {
  name                       = "poc-cont-env"
  location                   = azurerm_resource_group.rg_main.location
  resource_group_name        = azurerm_resource_group.rg_main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id
}

# Create a container registry
# resource "azurerm_container_registry" "acr" {
#   name                = var.acr_name
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   sku                 = "Basic"
#   admin_enabled       = true
# }

# Container App to host NGINX webpage
resource "azurerm_container_app" "nginx_app" {
  name                         = "nginx-web-app"
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  resource_group_name          = azurerm_resource_group.rg_main.name
  revision_mode                = "Single"

  template {
    container {
      name   = "nginx-container"
      image  = "nginx:latest" # Official NGINX image
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
  ingress {
    external_enabled = true
    target_port      = 80 # Expose port 80 for HTTP traffic

    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}