variable "enable_cluster_autoscaler" {
  description = "Whether to enable the cluster autoscaler module"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "ARN of the OIDC provider associated with the EKS cluster"
  type        = string
}

