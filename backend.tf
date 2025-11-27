# backend.tf

#terraform {
#  backend "local" {
   # path = "./terraform.tfstate"  # Le fichier d'état local (qui sera commité dans GitHub)
  #}
#"
#}
terraform {
  backend "azurerm" {
    resource_group_name   = "Backend_TFSTATE"
    storage_account_name  = "backendtfstatedeep"
    container_name        = "tfstates"
    key                    = "terraform.tfstate"
  }
}
