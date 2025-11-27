provider "azurerm" {
  features {}

  # Tu peux aussi spécifier les informations d'authentification via les variables d'environnement si nécessaire.
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
