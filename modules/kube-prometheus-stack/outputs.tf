
output "iam_role_arn" {
  description = "ARN of IAM role for kube_prometheus_stack"
  value       = var.enabled ? try(aws_iam_role.this[0].arn, "") : null
}

output "kube_prometheus_stack" {
  description = "kube_prometheus_stack Release Details"
  value = var.enabled ? {
    id        = helm_release.kube_prometheus_stack[0].id
    name      = helm_release.kube_prometheus_stack[0].name
    namespace = helm_release.kube_prometheus_stack[0].namespace
  } : null
}