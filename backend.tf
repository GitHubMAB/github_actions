# backend.tf

terraform {
  backend "azurerm" {
    storage_account_name = "myterraformbackend"  # Nom de ton Storage Account
    container_name       = "tfstatestorage"     # Nom de ton Container Blob
    key                   = "workflow.tfstate" # Nom du fichier d'état
  }
}
