
output "iam_role_arn" {
  description = "ARN of IAM role for Prometheus"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "loki" {
  description = "Loki Release Details"
  value = var.enabled ? {
    id        = helm_release.loki[0].id
    name      = helm_release.loki[0].name
    namespace = helm_release.loki[0].namespace
  } : null
}

output "s3_bucket_id" {
  value       = var.create_bucket ? aws_s3_bucket.loki[0].id : var.bucket_name
  description = "S3 Bucket ID"
}

output "promtail" {
  description = "Promtail Release Details"
  value = var.promtail_enabled ? {
    id        = helm_release.promtail[0].id
    name      = helm_release.promtail[0].name
    namespace = helm_release.promtail[0].namespace
  } : null
}