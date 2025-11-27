# variables.tf

variable "subscription_id" {
  description = "L'ID de la souscription Azure"
  type        = string
}

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
