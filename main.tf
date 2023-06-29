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

  enabled                          = var.enable_prometheus
  prometheus_version               = "22.6.2"
  prometheus_endpoint              = var.prometheus_endpoint
  region                           = var.region
  monitoring_account_id            = var.monitoring_aws_account_id
  cross_account_enabled            = true
  enable_blackbox_exporter         = var.enable_blackbox_exporter
  blackbox_exporter_host           = var.blackbox_exporter_host
  monitored_endpoints              = var.monitored_endpoints
  attach_grafana_cloudwatch_policy = var.attach_grafana_cloudwatch_policy
  scrape_interval                  = var.prometheus_scrape_interval
  eval_interval                    = var.prometheus_evaluation_interval

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

  enabled                   = var.enable_blackbox_exporter
  blackbox_exporter_version = "7.10.0"
}

module "nginx_ingress_controller" {
  source = "./modules/nginx-ingress-controller"

  enabled                          = var.enable_nginx_ingress_controller
  nginx_ingress_controller_version = "4.7.0"
}

module "loki_stack" {
  source = "./modules/loki-stack"

  enabled                        = var.enable_loki
  promtail_enabled               = var.enable_promtail
  loki_gateway_enabled           = var.enable_loki_gateway
  loki_gateway_target_group_arn  = var.loki_gateway_target_group_arn
  create_bucket                  = var.create_loki_bucket
  region                         = var.bucket_region
  bucket_name                    = var.loki_bucket_name
  loki_version                   = "5.8.6"
  grafana_agent_operator_version = "0.2.16"
  promtail_version               = "6.11.5"

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:loki"]
    }
  }
  role_name_prefix = "aws-loki-role-"
}