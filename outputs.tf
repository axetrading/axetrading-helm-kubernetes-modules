output "eks_cluster_autoscaler" {
  description = "EKS Cluster Autoscaler module outputs"
  value = var.enable_cluster_autoscaler ? {
    cluster_autoscaler_iam_role_arn           = module.eks_cluster_autoscaler.iam_role_arn,
    cluster_autoscaler_helm_release_id        = module.eks_cluster_autoscaler.helm_release_id,
    cluster_autoscaler_helm_release_name      = module.eks_cluster_autoscaler.helm_release_name,
    cluster_autoscaler_helm_release_namespace = module.eks_cluster_autoscaler.helm_release_namespace,
  } : null
}

output "prometheus" {
  description = "Prometheus module outputs"
  value = var.enable_prometheus ? {
    prometheus_helm_release_id        = module.prometheus.helm_release_id,
    prometheus_helm_release_name      = module.prometheus.helm_release_name,
    prometheus_helm_release_namespace = module.prometheus.helm_release_namespace,
  } : null
}

output "statsd_exporter" {
  description = "StatsD Exporter module outputs"
  value = var.enable_statsd_exporter ? {
    statsd_exporter_helm_release_id        = module.statsd_exporter.helm_release_id,
    statsd_exporter_helm_release_name      = module.statsd_exporter.helm_release_name,
    statsd_exporter_helm_release_namespace = module.statsd_exporter.helm_release_namespace,
  } : null
}