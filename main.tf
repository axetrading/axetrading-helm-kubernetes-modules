module "eks_cluster_autoscaler" {
  source = "./modules/cluster-autoscaler"

  enabled                          = var.enable_cluster_autoscaler
  cluster_name                     = var.cluster_name
  cluster_autoscaler_version       = "9.29.0"
  region                           = var.region
  scale_down_utilization_threshold = var.cluster_autoscaler_scale_down_utilization_threshold

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

  enabled                             = var.enable_prometheus
  alertmanager_enabled                = var.enable_alertmanager
  alertmanager_target_group_arn       = var.alertmanager_target_group_arn
  attach_grafana_cloudwatch_policy    = var.attach_grafana_cloudwatch_policy
  blackbox_exporter_host              = var.blackbox_exporter_host
  cross_account_enabled               = true
  enable_blackbox_exporter            = var.enable_blackbox_exporter
  eval_interval                       = var.prometheus_evaluation_interval
  monitored_endpoints                 = var.monitored_endpoints
  monitoring_account_id               = var.monitoring_aws_account_id
  prometheus_endpoint                 = var.prometheus_endpoint
  prometheus_gateway_enabled          = var.enable_prometheus_gateway
  prometheus_gateway_target_group_arn = var.prometheus_gateway_target_group_arn
  prometheus_version                  = "22.6.2"
  region                              = var.region
  scrape_interval                     = var.prometheus_scrape_interval

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
  monitored_endpoints       = var.blackbox_monitored_endpoints
}

module "nginx_ingress_controller" {
  source = "./modules/nginx-ingress-controller"

  enabled                          = var.enable_nginx_ingress_controller
  nginx_ingress_controller_version = "4.7.0"
  ingress_nginx_target_group_arn   = var.ingress_nginx_target_group_arn
}

module "postgres_exporter" {
  source                    = "./modules/postgres-exporter"
  enabled                   = var.enable_postgres_exporter
  postgres_exporter_version = "5.1.0"
  datasources_secret_key    = var.datasource_secrets["secret_key"]
  datasources_secret_name   = var.datasource_secrets["secret_name"]
  enable_stat_statements    = var.stat_statements_enabled

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:postgres-exporter"]
    }
  }
  role_name_prefix = "rds-postgres-exporter-"
}