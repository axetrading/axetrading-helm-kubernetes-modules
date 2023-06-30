output "statsd_exporter" {
  description = "Statsd Exporter Release Details"
  value = var.enabled ? {
    id        = helm_release.statsd_exporter[0].id
    name      = helm_release.statsd_exporter[0].name
    namespace = helm_release.statsd_exporter[0].namespace
  } : null
}
