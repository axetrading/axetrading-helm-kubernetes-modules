variable "enabled" {
  description = "Enable statsd-exporter"
  type        = bool
  default     = false
}

variable "statsd_exporter_version" {
  type        = string
  description = "Version of the statsd-exporter Helm chart"
  default     = "0.8.0"
}

variable "statsd_high_availability_enabled" {
  type        = bool
  description = "Enable high availability for statsd-exporter"
  default     = false
}

variable "statsd_exporter_target_group_arn" {
  type        = string
  description = "ARN of the target group to attach the statsd-exporter to"
  default     = null
}