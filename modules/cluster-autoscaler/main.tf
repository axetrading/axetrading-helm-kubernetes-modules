resource "helm_release" "cluster_autoscaler" {
  count = var.enabled ? 1 : 0

  name       = "aws-cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.cluster_autoscaler_version
  namespace  = "kube-system"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "autoDiscovery.tags"
    value = "kubernetes.io/cluster/${var.cluster_name}"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }

}
