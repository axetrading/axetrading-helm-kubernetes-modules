/*
  This block deploys Prometheus server using the Helm provider in Terraform. 
  The `helm_release` resource creates a Kubernetes deployment for the Prometheus server, with the specified chart version and configuration options. 
  The Prometheus server is used for monitoring and alerting in Kubernetes clusters.
*/

locals {
  prometheus_config_files = [
    file("${path.module}/config/alerting_rules.yml"),
    file("${path.module}/config/prometheus.yml"),
    var.enable_blackbox_exporter ? templatefile("${path.module}/config/blackbox_exporter.tpl", {
      monitored_endpoints    = var.monitored_endpoints
      blackbox_exporter_host = var.blackbox_exporter_host
    }) : null
  ]
  prometheus_config = compact(local.prometheus_config_files)
}

resource "helm_release" "prometheus" {
  count = var.enabled ? 1 : 0

  name       = "aws-amp"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.prometheus_version
  namespace  = "monitoring"
  values     = local.prometheus_config

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
    name  = "server.remoteWrite[0].sigv4.role_arn"
    value = "arn:aws:iam::${var.monitoring_account_id}:role/EKS-AMP-Central-Role"
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

  set {
    name  = "server.global.scrape_interval"
    value = var.scrape_interval
  }

  set {
    name  = "server.global.evaluation_interval"
    value = var.eval_interval
  }

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "serviceAccounts.server.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }
  depends_on = [helm_release.prometheus_operator_crds]
}


resource "helm_release" "prometheus_operator_crds" {
  count = var.enabled ? 1 : 0

  name       = "prometheus-operator-crds"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-operator-crds"
  version    = var.prometheus_operator_crds_version
  namespace  = "monitoring"
}


resource "helm_release" "prometheus_targetgroupbinding_crds" {
  count = var.enabled && var.prometheus_gateway_enabled ? 1 : 0
  name  = "aws-amp-prometheus-server-gateway"
  chart = "${path.cwd}/modules/helm-template/crds"
  values = [
    <<-EOF
  apiVersion: elbv2.k8s.aws/v1beta1
  kind: TargetGroupBinding
  metadata:
    name: aws-amp-prometheus-server-gateway
    namespace: monitoring
  spec:
    serviceRef:
      name: aws-amp-prometheus-server
      port: 80
    targetGroupARN: ${var.prometheus_gateway_target_group_arn}
    targetType: ip
    EOF
  ]

  depends_on = [
    helm_release.prometheus
  ]
}

resource "helm_release" "alertmanager_targetgroupbinding_crds" {
  count = var.enabled && var.alertmanager_enabled ? 1 : 0
  name  = "aws-amp-alertmanager-gateway"
  chart = "${path.cwd}/modules/helm-template/crds"
  values = [
    <<-EOF
  apiVersion: elbv2.k8s.aws/v1beta1
  kind: TargetGroupBinding
  metadata:
    name: aws-amp-alertmanager-gateway
    namespace: monitoring
  spec:
    serviceRef:
      name: aws-amp-alertmanager
      port: 9093
    targetGroupARN: ${var.alertmanager_target_group_arn}
    targetType: ip
    EOF
  ]

  depends_on = [
    helm_release.prometheus
  ]
}
