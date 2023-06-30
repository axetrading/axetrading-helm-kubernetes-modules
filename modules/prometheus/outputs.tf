
output "iam_role_arn" {
  description = "ARN of IAM role for Prometheus"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "prometheus" {
  description = "Prometheus Release Details"
  value = var.enabled ? {
    id        = helm_release.prometheus[0].id
    name      = helm_release.prometheus[0].name
    namespace = helm_release.prometheus[0].namespace
  } : null
}