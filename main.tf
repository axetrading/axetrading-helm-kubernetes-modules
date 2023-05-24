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
