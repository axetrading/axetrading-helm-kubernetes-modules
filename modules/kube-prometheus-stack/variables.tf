variable "enabled" {
  description = "Whether to create the kube-prometheus-stack resources"
  type        = bool
  default     = false
}

variable "kube_prometheus_stack_version" {
  description = "Version of the Prometheus Server Helm chart"
  type        = string
  default     = "50.3.1"
}

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "policy_name_prefix" {
  description = "IAM policy name prefix"
  type        = string
  default     = "eks-policy"
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = set(string)
  default     = []
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}

variable "assume_role_condition_test" {
  description = "Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role"
  type        = string
  default     = "StringEquals"
}

variable "attach_secrets_policy" {
  type        = bool
  description = "Attach a policy that will allow the role to get secrets from AWS Secrets Manager or AWS SSM"
  default     = true
}

variable "additional_value_files" {
  type        = list(any)
  description = "A list of additional value files. It will work in the same way as helm -f value1.yaml -f value2.yaml"
  default     = []
}

variable "role_arn" {
  type        = string
  description = "Existing role ARN"
  default     = null
}

variable "create_service_account" {
  type        = bool
  description = "Whether to create a service account for Kubernetes Deployment"
  default     = true
}

variable "oidc_providers" {
  description = "Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts`"
  type        = any
  default     = {}
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "cross_account_enabled" {
  type        = bool
  description = "Whether to allow cross account access to AWS CloudWatch Logs and Metrics"
  default     = true
}

variable "attach_grafana_cloudwatch_policy" {
  type        = bool
  description = "Whether to attach the AWS managed Grafana CloudWatch policy to the IAM role"
  default     = false
}

variable "eval_interval" {
  type        = string
  description = "The evaluation interval for Prometheus"
  default     = "1m"
}

variable "scrape_interval" {
  type        = string
  description = "The scrape interval for Prometheus"
  default     = "15s"
}

variable "alertmanager_target_group_arn" {
  type        = string
  description = "The ARN of the target group for Alertmanager"
  default     = null
}

variable "alertmanager_enabled" {
  type        = bool
  description = "Whether to enable Alertmanager"
  default     = false
}

variable "alertmanager_log_level" {
  type        = string
  description = "Alertmanager log level"
  default     = "info"
}

variable "prometheus_gateway_enabled" {
  type        = bool
  description = "Whether to enable Prometheus ALB Gateway"
  default     = false
}

variable "prometheus_gateway_target_group_arn" {
  type        = string
  description = "The ARN of the target group for Prometheus ALB Gateway"
  default     = null
}

variable "enable_default_prometheus_rules" {
  type        = bool
  description = "Whether to enable default Prometheus rules"
  default     = true
}

variable "prometheus_default_rules" {
  type        = map(any)
  description = "A map of Prometheus default rules"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster that will be added as a Prometheus External Label"
}

variable "thanos_sidecar_enabled" {
  type        = bool
  description = "Whether to enable Thanos sidecar"
  default     = false
}

variable "enable_thanos_external_service" {
  type        = bool
  description = "Whether to enable Thanos Sidecar external service"
  default     = false
}

variable "thanos_sidecar_target_group_arn" {
  type        = string
  description = "The ARN of the target group for Thanos sidecar"
  default     = null
}

variable "thanos_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store Thanos data"
  default     = null
}

variable "thanos_sidecar_secret_name" {
  type        = string
  description = "The name of the aws secret that contains the Thanos sidecar bucket configuration"
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
  description = "The PagerDuty URL to send alerts to"
  default     = null
  sensitive   = true
}

variable "pagerduty_service_key" {
  type        = string
  description = "The PagerDuty service key to authenticate and send alerts"
  default     = null
  sensitive   = true
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

variable "prometheus_scrape_interval" {
  type        = string
  description = "The Prometheus scrape interval in seconds"
  default     = "30"
}

variable "prometheus_scrape_timeout" {
  type        = string
  description = "The Prometheus scrape timeout interval in seconds"
  default     = "10"
}