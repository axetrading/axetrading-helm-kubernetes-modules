variable "enabled" {
  description = "Whether to create the cluster autoscaler"
  type        = bool
  default     = true
}

variable "cluster_autoscaler_version" {
  description = "Version of the cluster autoscaler Helm chart"
  type        = string
  default     = "9.29.0"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
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

variable "scale_down_utilization_threshold" {
  type = string
  description = "Value between 0.1 and 1.0. The scaleDownUtilizationThreshold defines the proportion between requested resources and capacity, which under the value cluster-autoscaler will trigger the scaling down action."
  default = "0.65"
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