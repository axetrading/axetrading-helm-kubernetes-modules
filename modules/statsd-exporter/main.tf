resource "helm_release" "statsd_exporter" {
    count = var.enabled ? 1 : 0

  name       = "statsd-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-statsd-exporter"
  version    = var.statsd_exporter_version
  namespace  = "monitoring"
  
  set {
    name = "fullnameOverride"
    value = "statsd-exporter"
    type = "string"
  }
  set {
    name = "prometheus.monitor.enabled"
    value = "true"
    type = "string"
  }
  set {
    name = "serviceMonitor.enabled"
    value = "true"
    type = "string"
  }
  set {
    name = "service.annotations.prometheus\\.io/scrape"
    value = "true"
    type = "string"
  }
}