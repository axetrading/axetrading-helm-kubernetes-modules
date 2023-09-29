variable "enable_cluster_autoscaler" {
  description = "Whether to enable the cluster autoscaler module"
  type        = bool
  default     = false
}

variable "enable_prometheus" {
  description = "Whether to enable the prometheus module"
  type        = bool
  default     = false
}

variable "enable_statsd_exporter" {
  description = "Whether to enable the statsd exporter module"
  type        = bool
  default     = false
}

variable "enable_blackbox_exporter" {
  description = "Whether to enable the blackbox exporter module"
  type        = bool
  default     = false
}

variable "prometheus_endpoint" {
  type        = string
  description = "AWS Managed Prometheus endpoint URL"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "ARN of the OIDC provider associated with the EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}


variable "monitoring_aws_account_id" {
  description = "AWS account ID where the monitoring stack is deployed"
  type        = string
}

variable "monitored_endpoints" {
  description = "The endpoints to be monitored by Prometheus"
  type = object({
    http_endpoints = optional(list(string), null)
    tcp_endpoints  = optional(list(string), null)
    icmp_endpoints = optional(list(string), null)
    ssh_endpoints  = optional(list(string), null)
  })
  default = {
    http_endpoints = null
    tcp_endpoints  = null
    icmp_endpoints = null
    ssh_endpoints  = null
  }
}


variable "blackbox_exporter_host" {
  type        = string
  description = "Prometheus Blackbox Exporter host"
  default     = "prometheus-blackbox-exporter.monitoring.svc.cluster.local"
}

variable "attach_grafana_cloudwatch_policy" {
  description = "Whether to attach the Grafana CloudWatch policy to the IAM role"
  type        = bool
  default     = true
}

variable "prometheus_evaluation_interval" {
  type        = string
  description = "The evaluation interval for Prometheus"
  default     = "1m"
}

variable "prometheus_scrape_interval" {
  type        = string
  description = "The scrape interval for Prometheus"
  default     = "15s"
}

variable "enable_nginx_ingress_controller" {
  description = "Whether to enable the nginx ingress controller module"
  type        = bool
  default     = false
}

variable "enable_loki" {
  description = "Whether to enable the loki stack module"
  type        = bool
  default     = false
}

variable "enable_promtail" {
  description = "Whether to enable the promtail module"
  type        = bool
  default     = false
}

variable "create_loki_bucket" {
  description = "Whether to create the Loki bucket"
  type        = bool
  default     = true
}

variable "loki_existing_bucket_name" {
  description = "Name of an existing S3 bucket for Loki"
  type        = string
  default     = null
}

variable "bucket_region" {
  description = "S3 Region of the Loki bucket"
  type        = string
  default     = "eu-west-2"
}

variable "enable_loki_gateway" {
  description = "Whether to enable the Loki gateway module"
  type        = bool
  default     = false
}

variable "loki_gateway_target_group_arn" {
  description = "ARN of the target group for Loki Gateway"
  type        = string
  default     = null
}

variable "loki_bucket_name" {
  description = "Name of the Loki bucket"
  type        = string
  default     = "axetrading-loki"
}

variable "enable_alertmanager" {
  description = "Whether to enable the alertmanager module"
  type        = bool
  default     = false
}

variable "enable_prometheus_gateway" {
  description = "Whether to enable the prometheus gateway module"
  type        = bool
  default     = false
}

variable "alertmanager_target_group_arn" {
  description = "ARN of the target group for Alertmanager"
  type        = string
  default     = null
}

variable "prometheus_gateway_target_group_arn" {
  description = "ARN of the target group for Prometheus Gateway"
  type        = string
  default     = null
}

variable "ingress_nginx_target_group_arn" {
  description = "ARN of the target group to bind the ingress controller to"
  type        = string
  default     = null
}


variable "enable_thanos" {
  description = "Whether to enable the thanos module"
  type        = bool
  default     = false
}

variable "enable_thanos_gateway" {
  description = "Whether to enable the thanos gateway module"
  type        = bool
  default     = false
}

variable "thanos_bucket_name" {
  description = "Name of the Thanos bucket"
  type        = string
  default     = null
}

variable "create_thanos_bucket" {
  description = "Whether to create the Thanos bucket"
  type        = bool
  default     = false
}

variable "thanos_bucket_region" {
  description = "S3 Region of the Thanos bucket"
  type        = string
  default     = "eu-west-2"
}

variable "thanos_existing_bucket_name" {
  description = "Name of an existing S3 bucket for Thanos"
  type        = string
  default     = null
}

variable "thanos_gateway_target_group_arn" {
  description = "ARN of the target group for Thanos Gateway"
  type        = string
  default     = null
}

variable "enable_kube_prometheus_stack" {
  description = "Whether to enable the kube-prometheus-stack module"
  type        = bool
  default     = false
}

variable "enable_thanos_sidecar" {
  description = "Whether to enable the thanos sidecar module"
  type        = bool
  default     = false
}

variable "enable_default_prometheus_rules" {
  description = "Whether to enable the default Prometheus rules"
  type        = bool
  default     = false
}

variable "prometheus_default_rules" {
  type        = map(any)
  description = "A map of Prometheus default rules"
  default     = null
}

variable "thanos_sidecar_target_group_arn" {
  description = "ARN of the target group for Thanos Sidecar"
  type        = string
  default     = null
}

variable "enable_prometheus_alertmanager" {
  description = "Whether to enable the prometheus alertmanager module"
  type        = bool
  default     = false
}

variable "kubernetes_cluster_name" {
  description = "Name of the Kubernetes cluster where Prometheus Stack is going to be deployed"
  type        = string
}

variable "thanos_stores_endpoints" {
  description = "The endpoints of the Thanos stores"
  type        = list(string)
  default     = null
}

variable "enable_thanos_external_service" {
  description = "Whether to enable the thanos sidecar external service"
  type        = bool
  default     = false
}

variable "thanos_sidecar_secret_name" {
  description = "Name of the Thanos sidecar secret"
  type        = string
  default     = null
}

variable "slack_api_url" {
  type        = string
  description = "The Slack Channel API URL where the alerts will be sent"
  default     = null
  sensitive   = true
}

variable "slack_channel" {
  type        = string
  description = "The Slack Channel where the alerts will be sent"
  default     = "monitoring"
}

variable "pagerduty_url" {
  type        = string
  description = "The PagerDuty URL where the alerts will be sent"
  default     = null
  sensitive   = true
}

variable "pagerduty_service_key" {
  type = string
  description = "The PagerDuty service key where the alerts will be sent"
  default = null
  sensitive = true
}

variable "prometheus_external_url" {
  type        = string
  description = "The Prometheus external URL"
  default     = null
}

variable "alertmanager_external_url" {
  type        = string
  description = "The Alertmanager external URL"
  default     = null
}


variable "thanos_query_autoscaling_enabled" {
  description = "Whether to enable autoscaling for Thanos Query"
  type        = bool
  default     = false
}

variable "thanos_query_autoscaling_min_replicas" {
  description = "Minimum number of replicas for Thanos Query autoscaling"
  type        = number
  default     = 2
}

variable "thanos_query_autoscaling_max_replicas" {
  description = "Maximum number of replicas for Thanos Query autoscaling"
  type        = number
  default     = 10
}

variable "thanos_query_autoscaling_target_cpu_utilization_percentage" {
  description = "Target CPU utilization percentage for Thanos Query autoscaling"
  type        = number
  default     = 80
}

variable "thanos_query_autoscaling_target_memory_utilization_percentage" {
  description = "Target memory utilization percentage for Thanos Query autoscaling"
  type        = number
  default     = 80
}

variable "thanos_query_resources_requests_cpu" {
  description = "CPU requests for Thanos Query"
  type        = string
  default     = "100m"
}

variable "thanos_query_resources_requests_memory" {
  description = "Memory requests for Thanos Query"
  type        = string
  default     = "256Mi"
}

variable "thanos_query_resources_limits_memory" {
  description = "Memory limits for Thanos Query"
  type        = string
  default     = "256Mi"
}

variable "thanos_storegateway_replica_count" {
  description = "Number of replicas for Thanos Store Gateway"
  type        = number
  default     = 2
}

variable "enable_thanos_receiver" {
  description = "Whether to enable the thanos receiver module"
  type        = bool
  default     = false
}

variable "thanos_receiver_target_group_arn" {
  description = "ARN of the target group for Thanos Receiver"
  type        = string
  default     = null
}

variable "thanos_receiver_remote_write_port" {
  description = "Port for Thanos Receiver remote write"
  type        = number
  default     = 19291
}

variable "blackbox_monitored_endpoints" {
  description = "The endpoints to be monitored by Prometheus"
  type = object({
    http_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    tcp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    icmp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    ssh_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
  })
  default = {
    http_endpoints = null
    tcp_endpoints  = null
    icmp_endpoints = null
    ssh_endpoints  = null
  }
}

variable "enable_postgres_exporter" {
  default     = false
  description = "Whether to enable postgres exporter"
  type        = bool
}

variable "datasource_secrets" {
  type        = map(string)
  description = "The secrets for the Prometheus Postgres Exporter datasource"
  default = {
    secret_key  = ""
    secret_name = ""
  }
}
