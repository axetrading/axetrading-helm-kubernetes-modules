locals {
  blackbox_exporter_config = [templatefile("${path.module}/config/blackbox.tpl", {
    monitored_endpoints = var.monitored_endpoints
  })]
}
resource "helm_release" "blackbox_exporter" {
  count = var.enabled ? 1 : 0

  name       = "prometheus-blackbox-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  version    = var.blackbox_exporter_version
  namespace  = "monitoring"
  values     = local.blackbox_exporter_config

  set {
    name  = "fullnameOverride"
    value = "prometheus-blackbox-exporter"
    type  = "string"
  }

  set {
    name  = "service.annotations.prometheus\\.io/scrape"
    value = "true"
    type  = "string"
  }

  set {
    name  = "serviceMonitor.enabled"
    value = true
  }

  set {
    name  = "serviceMonitor.selfMonitor.enabled"
    value = true
  }

  set {
    name  = "commonLabels.release"
    value = "prometheus"
  }

  set {
    name  = "serviceMonitor.defaults.interval"
    value = "15s"
  }

  set {
    name  = "serviceMonitor.defaults.scrapeTimeout"
    value = "10s"
  }
}
