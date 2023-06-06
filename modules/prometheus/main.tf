/*
  This block deploys Prometheus server using the Helm provider in Terraform. 
  The `helm_release` resource creates a Kubernetes deployment for the Prometheus server, with the specified chart version and configuration options. 
  The Prometheus server is used for monitoring and alerting in Kubernetes clusters.
*/

resource "helm_release" "prometheus" {
  count = var.enabled ? 1 : 0

  name       = "aws-amp"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.prometheus_version
  namespace  = "monitoring"

  set {
    name  = "serviceAccounts.server.name"
    value = var.create_service_account ? "amp-iamproxy-ingest-service-account" : null
    type  = "string"
  }

  set {
    name  = "server.remoteWrite[0].url"
    value = var.prometheus_endpoint
  }

  set {
    name  = "server.remoteWrite[0].sigv4.region"
    value = var.region
  }

  set {
    name  = "server.remoteWrite[0].queue_config.max_samples_per_send"
    value = "1000"
  }

  set {
    name  = "server.remoteWrite[0].queue_config.max_shards"
    value = "200"
  }

  set {
    name  = "server.remoteWrite[0].queue_config.capacity"
    value = "2500"
  }

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "serviceAccount.server.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }
}
