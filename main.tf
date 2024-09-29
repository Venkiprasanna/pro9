provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myResourceGroup" {
  name     = "myResourceGroup"
  location = "Canada Central"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.myResourceGroup.location
  resource_group_name = azurerm_resource_group.myResourceGroup.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks_rbac" {
  principal_id         = "12683d8f-e312-4780-a413-d7d87e933024"  # Replace with the Azure AD user's object ID
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
}

# Define a new node pool if needed
resource "azurerm_kubernetes_cluster_node_pool" "node_pool_1" {
  name                  = "nodepool1"  # Name for the new node pool
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size              = "Standard_DS2_v2"  # Specify VM size
  node_count           = 1                    # Number of nodes

  # Optional settings
  enable_auto_scaling = false  # Change to true to enable auto-scaling
}

# Optionally, you can add more node pools here by duplicating the above resource block.
