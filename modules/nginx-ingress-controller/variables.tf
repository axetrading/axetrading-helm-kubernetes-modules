variable "enabled" {
  description = "Enable nginx-ingress-controller module"
  type        = bool
  default     = false
}

variable "nginx_ingress_controller_version" {
  description = "nginx-ingress-controller version"
  type        = string
  default     = "4.7.0"
}

variable "ingress_nginx_target_group_arn" {
  description = "ARN of the target group to bind the ingress controller to"
  type        = string
  default     = null
}