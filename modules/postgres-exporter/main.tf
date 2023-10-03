locals {
  postgres_exporter_config_files = [
    templatefile("${path.module}/config/postgres-exporter.tpl", {
      datasources_secret_name = var.datasources_secret_name,
      datasources_secret_key  = var.datasources_secret_key
    })
  ]
  postgres_exporter_config = compact(local.postgres_exporter_config_files)
}

resource "helm_release" "postgres_exporter" {
  count = var.enabled ? 1 : 0

  name      = "postgres-exporter"
  chart     = "${path.module}/helm/prometheus-postgres-exporter"
  version   = var.postgres_exporter_version
  namespace = "monitoring"
  values    = local.postgres_exporter_config

  dynamic "set" {
    for_each = var.create_role && var.create_service_account ? [aws_iam_role.this[0].arn] : [var.role_arn]
    content {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "serviceMonitor.enabled"
    value = true
  }

  set {
    name  = "fullnameOverride"
    value = "postgres-exporter"
  }

  set {
    name  = "enableStatStatements"
    value = var.enable_stat_statements
  }
}