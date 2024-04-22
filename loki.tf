module "loki_stack" {
  source = "./modules/loki-stack"

  enabled                        = var.enable_loki
  promtail_enabled               = var.enable_promtail
  loki_gateway_enabled           = var.enable_loki_gateway
  loki_gateway_target_group_arn  = var.loki_gateway_target_group_arn
  loki_bucket_name               = var.loki_bucket_name
  create_bucket                  = var.create_loki_bucket
  region                         = var.bucket_region
  bucket_name                    = var.loki_existing_bucket_name
  loki_version                   = "6.3.3"
  grafana_agent_operator_version = "0.3.15"
  promtail_version               = "6.15.5"

  oidc_providers = {
    main = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["monitoring:loki"]
    }
  }
  role_name_prefix = "aws-loki-role-"
}
