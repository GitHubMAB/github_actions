# Fournisseur Azure
provider "azurerm" {
  features {}
  subscription_id = "0dcb06ec-28ba-41a8-9b8e-832342f38cb0"
}

# Variables pour personnaliser la configuration
variable "rg_name" {
  description = "Le nom du groupe de ressources"
  type        = string
  default     = "my-resource-group"
}

variable "location" {
  description = "La région où le groupe de ressources sera créé"
  type        = string
  default     = "westeurope"
}

# Créer le groupe de ressources
resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

output "resource_group_id" {
  value = azurerm_resource_group.example.id
}

output "resource_group_location" {
  value = azurerm_resource_group.example.location
}
