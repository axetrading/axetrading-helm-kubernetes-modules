output "eks_cluster_autoscaler" {
  description = "EKS Cluster Autoscaler module outputs"
  value = var.enable_cluster_autoscaler ? {
    cluster_autoscaler_iam_role_arn           = module.eks_cluster_autoscaler.iam_role_arn,
    cluster_autoscaler_helm_release_id        = module.eks_cluster_autoscaler.helm_release_id,
    cluster_autoscaler_helm_release_name      = module.eks_cluster_autoscaler.helm_release_name,
    cluster_autoscaler_helm_release_namespace = module.eks_cluster_autoscaler.helm_release_namespace,
  } : null
}