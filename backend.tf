# backend.tf

terraform {
  backend "local" {
    path = "./terraform.tfstate"  # Le fichier d'état local (qui sera commité dans GitHub)
  }
}
