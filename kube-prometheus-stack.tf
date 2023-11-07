module "kube-prometheus-stack" {
  source = "./modules/kube-prometheus-stack"

  enabled                             = var.enable_kube_prometheus_stack
  kube_prometheus_stack_version       = "50.3.1"
  alertmanager_enabled                = var.enable_prometheus_alertmanager
  alertmanager_external_url           = var.alertmanager_external_url
  alertmanager_target_group_arn       = var.alertmanager_target_group_arn
  cluster_name                        = var.kubernetes_cluster_name
  enable_default_prometheus_rules     = var.enable_default_prometheus_rules
  enable_thanos_external_service      = var.enable_thanos_external_service
  prometheus_external_url             = var.prometheus_external_url
  prometheus_gateway_enabled          = var.enable_prometheus_gateway
  prometheus_gateway_target_group_arn = var.prometheus_gateway_target_group_arn
  slack_api_url                       = var.slack_api_url
  slack_channel                       = var.slack_channel
  pagerduty_url                       = var.pagerduty_url
  pagerduty_service_key               = var.pagerduty_service_key
  thanos_bucket_name                  = var.thanos_bucket_name
  thanos_sidecar_enabled              = var.enable_thanos_sidecar
  thanos_sidecar_secret_name          = var.thanos_sidecar_secret_name
  thanos_sidecar_target_group_arn     = var.thanos_sidecar_target_group_arn
  prometheus_default_rules = {
    etcd                        = false
    kubeApiserverAvailability   = false
    kubeApiserverBurnrate       = false
    kubeApiserverHistogram      = false
    kubeApiserverSlos           = false
    kubeControllerManager       = false
    kubePrometheusNodeRecording = false
    kubernetesSystem            = false
    kubeSchedulerAlerting       = false
    kubeSchedulerRecording      = false
    nodeExporterRecording       = false
    prometheusOperator          = false
    windows                     = false
  }
  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:prometheus-sa"]
    }
  }
  role_name_prefix = "prometheus-operator-"
}