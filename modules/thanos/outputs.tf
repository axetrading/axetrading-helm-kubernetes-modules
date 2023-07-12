
output "iam_role_arn" {
  description = "ARN of IAM role for Thanos"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "thanos" {
  description = "Loki Release Details"
  value = var.enabled ? {
    id        = helm_release.thanos[0].id
    name      = helm_release.thanos[0].name
    namespace = helm_release.thanos[0].namespace
  } : null
}

output "s3_bucket_id" {
  value       = var.create_bucket ? try(aws_s3_bucket.thanos[0].id, null) : var.thanos_bucket_name
  description = "S3 Bucket ID"
}
