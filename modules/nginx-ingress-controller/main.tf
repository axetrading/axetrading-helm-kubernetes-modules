resource "helm_release" "nginx_ingress_controller" {
  count = var.enabled ? 1 : 0

  name             = "nginx-ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = var.nginx_ingress_controller_version
  create_namespace = true

  set {
    name  = "fullnameOverride"
    value = "nginx-ingress-controller"
    type  = "string"
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
}