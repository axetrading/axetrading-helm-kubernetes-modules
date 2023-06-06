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
  cluster_name          = var.cluster_name
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
