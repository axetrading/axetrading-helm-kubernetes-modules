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
    name  = "loki.storage.s3.region"
    value = var.region
    type  = "string"
  }

  set {
    name  = "loki.storage.bucketNames.chunks"
    value = local.bucket_name
    type  = "string"
  }

  set {
    name  = "loki.storage.bucketNames.ruler"
    value = local.bucket_name
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

  dynamic "set" {
    for_each = var.loki_gateway_enabled ? [var.loki_gateway_enabled] : []
    content {
      name  = "gateway.enabled"
      value = set.value
    }
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

  set {
    name  = "loki.commonConfig.replication_factor"
    value = "1"
  }

  set {
    name  = "loki.query_scheduler.max_outstanding_requests_per_tenant"
    value = "4096"
  }

  set {
    name  = "loki.frontend.max_outstanding_per_tenant"
    value = "4096"
  }

  set {
    name  = "loki.limits_config.split_queries_by_interval"
    value = "24h"
  }

  set {
    name  = "loki.limits_config.max_query_parallelism"
    value = "100"
  }

  depends_on = [helm_release.grafana_agent_operator]
}

resource "kubernetes_manifest" "this" {
  count = var.enabled && var.loki_gateway_enabled ? 1 : 0
  manifest = {
    "apiVersion" = "elbv2.k8s.aws/v1beta1"
    "kind"       = "TargetGroupBinding"
    "metadata" = {
      "name"      = "loki-gateway"
      "namespace" = "monitoring"
    }
    "spec" = {
      "serviceRef" = {
        "name" = "loki-gateway"
        port   = 80
      }
      "targetGroupARN" = var.loki_gateway_target_group_arn
      "targetType"     = "ip"
    }
  }
}