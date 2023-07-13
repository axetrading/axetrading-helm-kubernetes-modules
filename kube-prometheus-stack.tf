module "kube-prometheus-stack" {
  source = "./modules/kube-prometheus-stack"

  enabled                             = var.enable_kube_prometheus_stack
  kube_prometheus_stack_version       = "47.6.1"
  alertmanager_enabled                = var.enable_prometheus_alertmanager
  alertmanager_target_group_arn       = var.alertmanager_target_group_arn
  enable_default_prometheus_rules     = var.enable_default_prometheus_rules
  enable_thanos_external_service      = var.enable_thanos_external_service
  prometheus_gateway_enabled          = var.enable_prometheus_gateway
  prometheus_gateway_target_group_arn = var.prometheus_gateway_target_group_arn
  cluster_name                        = var.kubernetes_cluster_name
  thanos_bucket_name                  = var.thanos_bucket_name
  thanos_sidecar_enabled              = var.enable_thanos_sidecar
  thanos_sidecar_target_group_arn     = var.thanos_sidecar_target_group_arn
  thanos_sidecar_secret_name          = var.thanos_sidecar_secret_name
  prometheus_default_rules = {
    windows                     = false
    etcd                        = false
    kubeApiserverAvailability   = false
    kubeApiserverBurnrate       = false
    kubeApiserverHistogram      = false
    kubeApiserverSlos           = false
    kubeControllerManager       = false
    kubePrometheusNodeRecording = false
    kubernetesSystem            = false
    kubeSchedulerRecording      = false
    nodeExporterRecording       = false
    windows                     = false
    prometheusOperator          = false
  }
  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:prometheus-sa"]
    }
  }
  role_name_prefix = "prometheus-operator-"
}