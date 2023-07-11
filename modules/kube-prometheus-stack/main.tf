/*
  This block deploys Prometheus server using the Helm provider in Terraform. 
  The `helm_release` resource creates a Kubernetes deployment for the Prometheus server, with the specified chart version and configuration options. 
  The Prometheus server is used for monitoring and alerting in Kubernetes clusters.
*/

locals {
  prometheus_config_files = [
    file("${path.module}/config/prometheus.yml"),
  ]
  prometheus_config = compact(local.prometheus_config_files)
}

resource "helm_release" "kube_prometheus_stack" {
  count = var.enabled ? 1 : 0

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_version
  namespace  = "monitoring"
  values     = local.prometheus_config

  set {
    name  = "defaultRules.create"
    value = var.enable_default_prometheus_rules ? true : false
  }

  set {
    name  = "grafana.enabled"
    value = false
  }

  dynamic "set" {
    for_each = var.enable_default_prometheus_rules && var.prometheus_default_rules != null ? var.prometheus_default_rules : {}
    content {
      name  = "defaultRules.rules.${set.key}"
      value = set.value
    }
  }

  set {
    name  = "prometheus.serviceAccount.name"
    value = var.create_service_account ? "prometheus-sa" : null
    type  = "string"
  }

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "prometheus.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "prometheus.thanosService.enabled"
    value = true
  }

  set {
    name  = "prometheus.thanosServiceMonitor.enabled"
    value = true
  }

  set {
    name  = "prometheus.prometheusSpec.externalLabels.cluster"
    value = var.cluster_name
  }
}


resource "helm_release" "prometheus_targetgroupbinding_crds" {
  count     = var.enabled && var.prometheus_gateway_enabled ? 1 : 0
  name      = "prometheus-server-gateway"
  chart     = "${path.module}/../helm-template/crds"
  namespace = "monitoring"

  set {
    name  = "fullnameOverride"
    value = "prometheus-server-gateway"
  }

  set {
    name  = "targetGroupBinding.service.name"
    value = "prometheus-kube-prometheus-prometheus"
  }

  set {
    name  = "targetGroupBinding.port"
    value = "9090"
  }

  set {
    name  = "targetGroupBinding.targetGroupARN"
    value = var.prometheus_gateway_target_group_arn
  }

  depends_on = [
    helm_release.kube_prometheus_stack
  ]
}

resource "helm_release" "alertmanager_targetgroupbinding_crds" {
  count     = var.enabled && var.alertmanager_enabled ? 1 : 0
  name      = "alertmanager-gateway"
  chart     = "${path.module}/../helm-template/crds"
  namespace = "monitoring"

  set {
    name  = "fullnameOverride"
    value = "alertmanager-gateway"
  }

  set {
    name  = "targetGroupBinding.service.name"
    value = "prometheus-kube-prometheus-alertmanager"
  }

  set {
    name  = "targetGroupBinding.port"
    value = "9093"
  }

  set {
    name  = "targetGroupBinding.targetGroupARN"
    value = var.alertmanager_target_group_arn
  }

  depends_on = [
    helm_release.kube_prometheus_stack
  ]
}

resource "helm_release" "thanos_sidecar_targetgroupbinding_crds" {
  count     = var.enabled && var.thanos_sidecar_enabled ? 1 : 0
  name      = "thanos-sidecar-gateway"
  chart     = "${path.module}/../helm-template/crds"
  namespace = "monitoring"

  set {
    name  = "fullnameOverride"
    value = "thanos-sidecar-gateway"
  }

  set {
    name  = "targetGroupBinding.service.name"
    value = "prometheus-kube-prometheus-thanos-discovery"
  }

  set {
    name  = "targetGroupBinding.port"
    value = "10901"
  }

  set {
    name  = "targetGroupBinding.targetGroupARN"
    value = var.thanos_sidecar_target_group_arn
  }

  depends_on = [
    helm_release.kube_prometheus_stack
  ]
}
