
output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "cluster_autoscaler" {
  description = "Blackbox Exporter Release Details"
  value = var.enabled ? {
    id        = helm_release.cluster_autoscaler[0].id
    name      = helm_release.cluster_autoscaler[0].name
    namespace = helm_release.cluster_autoscaler[0].namespace
  } : null
}