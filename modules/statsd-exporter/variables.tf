variable "enabled" {
  description = "Enable statsd-exporter"
  type        = bool
  default     = false
}

variable "statsd_exporter_version" {
  type        = string
  description = "Version of the statsd-exporter Helm chart"
  default     = "0.13.0"
}
