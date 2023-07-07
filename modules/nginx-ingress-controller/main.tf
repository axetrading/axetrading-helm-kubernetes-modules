resource "helm_release" "monitoring_nginx_ingress_controller" {
  count = var.enabled ? 1 : 0

  name             = "monitoring-nginx-ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = var.nginx_ingress_controller_version
  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "NodePort"
    type  = "string"
  }

  set {
    name  = "controller.kind"
    value = "DaemonSet"
    type  = "string"
  }

  set {
    name  = "controller.service.enableHttp"
    value = false
  }

  set {
    name  = "controller.ingressClass"
    value = "nginx-monitoring"
  }
}


resource "helm_release" "external_secrets_cluster_store" {
  count      = var.enabled && var.ingress_nginx_target_group_arn != null ? 1 : 0
  name       = "external-secrets-cluster-store"
  repository = "https://charts.itscontained.io"
  chart      = "raw"
  version    = "0.2.5"
  values = [
    <<-EOF
  apiVersion: elbv2.k8s.aws/v1beta1
  kind: TargetGroupBinding
  metadata:
    name: monitoring-ingress-nginx-controller
    namespace: ingress-nginx
  spec:
    serviceRef:
      name: monitoring-ingress-nginx-controller
      port: 443
    targetGroupARN: ${var.ingress_nginx_target_group_arn}
    targetType: ip
    EOF
  ]
  depends_on = [helm_release.monitoring_nginx_ingress_controller]
}