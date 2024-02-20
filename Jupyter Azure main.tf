provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

resource "azurerm_container_group" "example" {
  name                = "example-container-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "public"
  dns_name_label      = "example-container-group"

  container {
    name   = "jupyter-notebook"
    image  = "jupyter/datascience-notebook:latest"
    cpu    = "1.0"
    memory = "1.5"
    ports {
      port     = 8888
      protocol = "TCP"
    }
  }
}
