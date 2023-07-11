resource "helm_release" "statsd_exporter" {
  count = var.enabled ? 1 : 0

  name      = "statsd-exporter"
  chart     = "${path.module}/helm/prometheus-statsd-exporter"
  version   = var.statsd_exporter_version
  namespace = "monitoring"

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
  }

  set {
    name = "serviceMonitor.additionalLabels.release"
    value = "prometheus" 
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

}