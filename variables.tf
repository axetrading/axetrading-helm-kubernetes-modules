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

variable "loki_bucket_name" {
  description = "Name of the Loki bucket"
  type        = string
  default     = null
}

variable "bucket_region" {
  description = "S3 Region of the Loki bucket"
  type        = string
  default     = "eu-west-2"
}