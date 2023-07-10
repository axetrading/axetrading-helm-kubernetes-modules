resource "helm_release" "monitoring_nginx_ingress_controller" {
  count = var.enabled ? 1 : 0

  name             = "monitoring-nginx-ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = var.nginx_ingress_controller_version
  create_namespace = true
  set {
    name  = "fullnameOverride"
    value = "monitoring-ingress-controller"
  }

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
