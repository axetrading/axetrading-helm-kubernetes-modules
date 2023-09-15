
output "iam_role_arn" {
  description = "ARN of IAM role for postgres_exporter"
  value       = var.enabled ? try(aws_iam_role.this[0].arn, "") : null
}

output "postgres-exporter" {
  description = "Postgres Exporter Release Details"
  value = var.enabled ? {
    id        = helm_release.postgres_exporter[0].id
    name      = helm_release.postgres_exporter[0].name
    namespace = helm_release.postgres_exporter[0].namespace
  } : null
}