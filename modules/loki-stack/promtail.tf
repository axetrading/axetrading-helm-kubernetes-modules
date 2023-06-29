resource "helm_release" "promtail" {
  count = var.promtail_enabled ? 1 : 0

  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = var.promtail_version
  namespace  = "monitoring"
}