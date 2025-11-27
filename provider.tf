provider "azurerm" {
  features {}

  # Tu peux aussi spécifier les informations d'authentification via les variables d'environnement si nécessaire.
  subscription_id = var.subscription_id
}
