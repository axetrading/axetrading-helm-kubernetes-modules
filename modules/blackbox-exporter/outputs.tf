output "blackbox_exporter" {
  description = "Blackbox Exporter Release Details"
  value = var.enabled ? {
    id        = helm_release.blackbox_exporter[0].id
    name      = helm_release.blackbox_exporter[0].name
    namespace = helm_release.blackbox_exporter[0].namespace
  } : null
}