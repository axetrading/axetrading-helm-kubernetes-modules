variable "enabled" {
  description = "Whether to create the cluster autoscaler"
  type        = bool
  default     = true
}

variable "loki_version" {
  description = "Loki-stack helm chart version"
  type        = string
  default     = "5.8.6"
}

variable "grafana_agent_operator_version" {
  description = "Grafana Agent Operator helm chart version"
  type        = string
  default     = "0.2.16"
}

variable "create_bucket" {
  type        = bool
  default     = true
  description = "Create S3 bucket for Loki"
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment"
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

variable "bucket_name" {
  description = "Name of an existing S3 bucket for Loki"
  type        = string
  default     = null
}

variable "promtail_enabled" {
  description = "Whether to enable promtail"
  type        = bool
  default     = true
}

variable "loki_gateway_enabled" {
  type        = bool
  description = "Whether to enable Loki Gateway"
  default     = true
}

variable "loki_gateway_target_group_arn" {
  type        = string
  description = "ARN of the target group for Loki Gateway"
  default     = null
}

variable "loki_write_persistence_enabled" {
  type        = bool
  description = "Whether to enable Loki write persistence"
  default     = true
}

variable "loki_write_persistence_size" {
  type        = string
  description = "Size of the Loki write persistence volume"
  default     = "10Gi"
}

variable "promtail_version" {
  description = "Promtail helm chart version"
  type        = string
  default     = "6.11.5"
}

variable "loki_bucket_name" {
  description = "Name of the S3 bucket that will be created for Loki"
  type        = string
  default     = "axetrading-loki"
}

variable "loki_object_store_type" {
  description = "Type of object store to use for Loki"
  type        = string
  default     = "s3"
}

variable "loki_rules_enabled" {
  description = "Whether to enable Loki rules"
  type        = bool
  default     = true
}

variable "loki_read_persistence_size" {
  description = "Size of the Loki read persistence volume"
  type        = string
  default     = "20Gi"
}