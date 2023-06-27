locals {
  replica_count = 2
}
resource "helm_release" "statsd_exporter" {
  count = var.enabled ? 1 : 0

  name       = "statsd-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-statsd-exporter"
  version    = var.statsd_exporter_version
  namespace  = "monitoring"

  set {
    name  = "fullnameOverride"
    value = "prometheus-statsd-exporter"
    type  = "string"
  }

  set {
    name  = "service.annotations.prometheus\\.io/scrape"
    value = "true"
    type  = "string"
  }

  set {
    name  = "serviceMonitor.enabled"
    value = "true"
    type  = "string"
  }

  set {
    name  = "statsd.mappingConfig"
    value = trimspace(file("${path.module}/configs/mapping.yml"))
    type  = "string"
  }

  set_list {
    name  = "extraArgs"
    value = ["--log.level=debug"]
  }

  set {
    name  = "resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "resources.limits.memory"
    value = "128Mi"
  }

  dynamic "set" {
    for_each = var.enabled && var.statsd_high_availability_enabled ? [local.replica_count] : []
    content {
      name  = "replicaCount"
      value = set.value
      type  = "string"
    }
  }
}

resource "kubernetes_manifest" "this" {
  count = var.enabled && var.statsd_high_availability_enabled ? 1 : 0
  manifest = {
    "apiVersion" = "elbv2.k8s.aws/v1beta1"
    "kind"       = "TargetGroupBinding"
    "metadata" = {
      "name"      = "prometheus-statsd-exporter"
      "namespace" = "monitoring"
    }
    "spec" = {
      "serviceRef" = {
        "name" = "prometheus-statsd-exporter"
        port   = 9125
      }
      "targetGroupARN" = var.statsd_exporter_target_group_arn
      "targetType"     = "ip"
    }
  }
}