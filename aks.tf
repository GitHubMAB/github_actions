# -------------------------
# Resource Group
# -------------------------

resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-mab"
  location = "northeurope"
}

# -------------------------
# AKS Cluster
# -------------------------

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-demo"

  kubernetes_version  = "1.34.0"

  default_node_pool {
    name       = "system"
    node_count = 2
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}

# -------------------------
# Output kubeconfig
# -------------------------

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
