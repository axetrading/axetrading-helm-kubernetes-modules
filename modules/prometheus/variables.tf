variable "enabled" {
  description = "Whether to create the cluster autoscaler"
  type        = bool
  default     = true
}

variable "prometheus_version" {
  description = "Version of the Prometheus Server Helm chart"
  type        = string
  default     = "22.6.2"
}

variable "prometheus_operator_crds_version" {
  description = "Version of the Prometheus Operator CRDs Helm chart"
  type        = string
  default     = "4.0.2"
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

variable "prometheus_endpoint" {
  type        = string
  description = "AWS Managed Prometheus workspace endpoint URL"
  default     = null
}

variable "monitoring_account_id" {
  type        = string
  description = "AWS account ID where the AWS Managed Prometheus workspace is located"
  default     = null
}

variable "enable_blackbox_exporter" {
  description = "Whether to add the blackbox exporter jobs in prometheus"
  type        = bool
  default     = false
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

variable "cross_account_enabled" {
  type        = bool
  description = "Whether to allow cross account access to AWS CloudWatch Logs and Metrics"
  default     = true
}