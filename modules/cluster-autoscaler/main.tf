/*
Resource: Helm Release - cluster_autoscaler

Description: The Helm Release resource manages the installation and configuration of the cluster-autoscaler chart for Kubernetes clusters.

The cluster-autoscaler is an open-source tool that automatically adjusts the size of an Amazon EKS cluster based on the workload demand. It scales the number of worker nodes up or down to optimize resource utilization and maintain efficient cluster performance.

This resource sets up the cluster-autoscaler with the specified version and configuration options, including the cluster name, namespace, service account, and IAM role. It leverages the Helm package manager to install and manage the cluster-autoscaler chart, which is fetched from the official Kubernetes autoscaler repository.
*/

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

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "extraArgs.balance-similar-node-groups"
    value = "true"
  }

  set {
    name  = "extraArgs.skip-nodes-with-system-pods"
    value = "false"
  }

  set {
    name  = "extraArgs.scan-interval"
    value = "10s"
  }

  set {
    name  = "extraArgs.scale-down-enabled"
    value = "true"
  }

  set {
    name  = "extraArgs.skip-nodes-with-local-storage"
    value = "false"
  }

  set {
    name  = "prometheusRule.enabled"
    value = "true"
  }

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }
}
