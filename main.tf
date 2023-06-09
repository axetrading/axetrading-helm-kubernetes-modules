module "eks_cluster_autoscaler" {
  source = "./modules/cluster-autoscaler"

  enabled                    = var.enable_cluster_autoscaler
  cluster_name               = var.cluster_name
  cluster_autoscaler_version = "9.29.0"
  region                     = var.region

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
  role_name_prefix = "eks-cluster-autoscaler-"
}

module "prometheus" {
  source = "./modules/prometheus"

  enabled               = var.enable_prometheus
  prometheus_version    = "22.6.2"
  prometheus_endpoint   = var.prometheus_endpoint
  region                = var.region
  monitoring_account_id = var.monitoring_aws_account_id

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:amp-iamproxy-ingest-service-account"]
    }
  }
  role_name_prefix = "amp-iamproxy-ingest-role-"
}

module "statsd_exporter" {
  source = "./modules/statsd-exporter"

  enabled                 = var.enable_statsd_exporter
  statsd_exporter_version = "0.8.0"
}

module "blackbox_exporter" {
  source = "./modules/blackbox-exporter"

  enabled                 = var.enable_blackbox_exporter
  statsd_exporter_version = "7.10.0"
}