variable "enabled" {
  description = "Whether to create Thanos resources or not"
  type        = bool
  default     = true
}

variable "thanos_version" {
  description = "Thanos-stack helm chart version"
  type        = string
  default     = "5.8.6"
}

variable "create_bucket" {
  type        = bool
  default     = false
  description = "Create S3 bucket for Thanos"
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

variable "thanos_gateway_enabled" {
  type        = bool
  description = "Whether to enable Thanos Gateway"
  default     = true
}

variable "thanos_gateway_target_group_arn" {
  type        = string
  description = "ARN of the target group for Thanos Gateway"
  default     = null
}

variable "thanos_bucket_name" {
  description = "Name of the S3 bucket that will be created for Thanos"
  type        = string
  default     = null
}

variable "existing_bucket_name" {
  description = "Name of the an existing S3 bucket that will be used by Thanos"
  type        = string
  default     = null
}

variable "thanos_bucket_region" {
  description = "Region of the S3 bucket that will be created for Thanos"
  type        = string
  default     = "eu-west-2"
}

variable "thanos_objstore_endpoint" {
  description = "Endpoint of the S3 bucket that will be created for Thanos"
  type        = string
  default     = "s3.eu-west-2.amazonaws.com"
}

variable "thanos_stores_endpoints" {
  description = "Endpoints of Thanos Stores (Gateways or SideCars, Rulers) that will be attached to Thanos Query"
  type        = list(string)
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
  default     = "128Mi"
}

variable "thanos_query_resources_limits_memory" {
  description = "Memory limits for Thanos Query"
  type        = string
  default     = "128Mi"
}

variable "thanos_storegateway_replica_count" {
  description = "Number of replicas for Thanos Store Gateway"
  type        = number
  default     = 2
}