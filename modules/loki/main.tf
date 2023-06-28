/*
  * Terraform module to deploy Loki Stack on Kubernetes cluster.
  More details about Loki Stack: https://grafana.com/oss/loki/
  This module will create:
  - Loki Stack namespace
  - Loki Stack helm release
  - Loki Stack IAM role
  - Loki Stack S3 bucket
  - Loki Stack S3 bucket policy
  - Loki Stack S3 bucket lifecycle rule
*/

locals {
  bucket_name = var.create_bucket ? aws_s3_bucket.loki[0].id : var.bucket_name
}

resource "helm_release" "grafana_agent_operator" {
  count = var.enabled ? 1 : 0

  name       = "grafana-agent-operator"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana-agent-operator"
  version    = var.grafana_agent_operator_version
  namespace  = "monitoring"
}

resource "helm_release" "loki" {
  count = var.enabled ? 1 : 0

  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = var.loki_version
  namespace  = "monitoring"

  set {
    name  = "fullnameOverride"
    value = "loki"
  }

  set {
    name  = "loki.auth_enabled"
    value = false
  }

  dynamic "set" {
    for_each = var.create_role ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "loki.storage.type"
    value = "s3"
  }

  set {
    name  = "loki.storage.s3.s3"
    value = "s3://${var.region}/${local.bucket_name}"
  }

  set {
    name  = "loki.storage.s3.region"
    value = var.region
    type  = "string"
  }

  set {
    name  = "monitoring.selfMonitoring.enabled"
    value = false
  }

  set {
    name  = "monitoring.dashboards.enabled"
    value = false
  }

  set {
    name  = "monitoring.lokiCanary.enabled"
    value = false
  }

  set {
    name  = "gateway.enabled"
    value = false
  }

  set {
    name  = "monitoring.serviceMonitor.grafanaAgent.installOperator"
    value = false
  }

  set {
    name  = "test.enabled"
    value = false
  }

  set {
    name  = "backend.autoscaling.enabled"
    value = true
  }

  set {
    name  = "write.autoscaling.enabled"
    value = true
  }

  set {
    name  = "read.autoscaling.enabled"
    value = true
  }

  depends_on = [helm_release.grafana_agent_operator]
}

