resource "helm_release" "blackbox_exporter" {
  count = var.enabled ? 1 : 0

  name       = "prometheus-blackbox-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  version    = var.blackbox_exporter_version
  namespace  = "monitoring"
  values     = [file("${path.module}/blackbox.yml")]

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
}
