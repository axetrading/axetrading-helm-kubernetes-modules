variable "enabled" {
  description = "Enable blackbox-exporter"
  type        = bool
  default     = true
}

variable "blackbox_exporter_version" {
  type        = string
  description = "Version of the blackbox-exporter Helm chart"
  default     = "7.10.0"
}