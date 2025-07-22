output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
  description = "Pre-made kubeconfig for use in accessing the cluster"
}