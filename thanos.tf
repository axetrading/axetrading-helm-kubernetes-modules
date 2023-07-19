module "thanos" {
  source = "./modules/thanos"

  enabled        = var.enable_thanos
  thanos_version = "12.8.5"

  create_bucket                                                 = var.create_thanos_bucket
  existing_bucket_name                                          = var.thanos_existing_bucket_name
  thanos_bucket_name                                            = var.thanos_bucket_name
  thanos_bucket_region                                          = var.thanos_bucket_region
  thanos_gateway_enabled                                        = var.enable_thanos_gateway
  thanos_gateway_target_group_arn                               = var.thanos_gateway_target_group_arn
  thanos_query_autoscaling_enabled                              = var.thanos_query_autoscaling_enabled
  thanos_query_autoscaling_max_replicas                         = var.thanos_query_autoscaling_max_replicas
  thanos_query_autoscaling_min_replicas                         = var.thanos_query_autoscaling_min_replicas
  thanos_query_autoscaling_target_cpu_utilization_percentage    = var.thanos_query_autoscaling_target_cpu_utilization_percentage
  thanos_query_autoscaling_target_memory_utilization_percentage = var.thanos_query_autoscaling_target_memory_utilization_percentage
  thanos_query_resources_limits_memory                          = var.thanos_query_resources_limits_memory
  thanos_query_resources_requests_cpu                           = var.thanos_query_resources_requests_cpu
  thanos_query_resources_requests_memory                        = var.thanos_query_resources_requests_memory
  thanos_stores_endpoints                                       = var.thanos_stores_endpoints

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
