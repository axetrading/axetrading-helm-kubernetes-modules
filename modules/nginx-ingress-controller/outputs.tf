output "helm_release_id" {
  value       = helm_release.nginx_ingress_controller[0].id
  description = "Helm Release ID"
}

output "helm_release_name" {
  value       = helm_release.nginx_ingress_controller[0].name
  description = "Helm Release Name"
}

output "helm_release_namespace" {
  value       = helm_release.nginx_ingress_controller[0].namespace
  description = "Helm Release Namespace"
}