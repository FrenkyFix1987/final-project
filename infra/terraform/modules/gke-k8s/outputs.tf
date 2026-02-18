output "namespace_name" {
  value       = kubernetes_namespace.prod.metadata[0].name
}

output "backend_sa_name" {
  value       = kubernetes_service_account.backend.metadata[0].name
}
