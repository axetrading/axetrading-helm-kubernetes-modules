module "thanos" {
  source = "./modules/thanos"

  enabled                         = var.enable_thanos
  thanos_gateway_enabled          = var.enable_thanos_gateway
  thanos_gateway_target_group_arn = var.thanos_gateway_target_group_arn
  thanos_bucket_name              = var.thanos_bucket_name
  create_bucket                   = var.create_thanos_bucket
  thanos_bucket_region            = var.thanos_bucket_region
  existing_bucket_name            = var.thanos_existing_bucket_name
  thanos_version                  = "12.8.3"

  oidc_providers = {
    main = {
      provider_arn = var.eks_oidc_provider_arn
      namespace_service_accounts = [
        "monitoring:thanos-query",
        "thanos-query-frontend",
        "monitoring:thanos-storegateway",
        "monitoring:thanos-compactor",
        "monitoring:thanos-ruler"
      ]
    }
  }
  role_name_prefix = "thanos-central-"
}
