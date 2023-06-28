
output "iam_role_arn" {
  description = "ARN of IAM role for Prometheus"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "helm_release_id" {
  value       = helm_release.loki[0].id
  description = "Helm Release ID"
}

output "helm_release_name" {
  value       = helm_release.loki[0].name
  description = "Helm Release Name"
}

output "helm_release_namespace" {
  value       = helm_release.loki[0].namespace
  description = "Helm Release Namespace"
}