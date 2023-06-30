output "eks_cluster_autoscaler" {
  description = "EKS Cluster Autoscaler module outputs"
  value = var.enable_cluster_autoscaler ? {
    cluster_autoscaler_iam_role_arn = module.eks_cluster_autoscaler.iam_role_arn,
    cluster_autoscaler              = module.eks_cluster_autoscaler.cluster_autoscaler
  } : null
}

output "prometheus" {
  description = "Prometheus module outputs"
  value = var.enable_prometheus ? {
    prometheus_iam_role_arn = module.prometheus.iam_role_arn,
    prometheus              = module.prometheus.prometheus
  } : null
}

output "statsd_exporter" {
  description = "StatsD Exporter module outputs"
  value = var.enable_statsd_exporter ? {
    statsd_exporter = module.statsd_exporter.statsd_exporter
  } : null
}

output "blackbox_exporter" {
  description = "Blackbox Exporter module outputs"
  value = var.enable_blackbox_exporter ? {
    blackbox_exporter = module.blackbox_exporter.blackbox_exporter
  } : null
}