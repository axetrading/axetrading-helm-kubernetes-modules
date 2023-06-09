output "helm_release_id" {
  value       = helm_release.blackbox_exporter[0].id
  description = "Helm Release ID"
}

output "helm_release_name" {
  value       = helm_release.blackbox_exporter[0].name
  description = "Helm Release Name"
}

output "helm_release_namespace" {
  value       = helm_release.blackbox_exporter[0].namespace
  description = "Helm Release Namespace"
}