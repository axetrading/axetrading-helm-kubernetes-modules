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

variable "monitored_endpoints" {
  description = "The endpoints to be monitored by Prometheus"
  type = object({
    http_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, 15)
      timeout  = optional(string, 10)
    })), null)
    tcp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, 15)
      timeout  = optional(string, 10)
    })), null)
    icmp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, 15)
      timeout  = optional(string, 10)
    })), null)
    ssh_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, 15)
      timeout  = optional(string, 10)
    })), null)
  })
  default = {
    http_endpoints = null
    tcp_endpoints  = null
    icmp_endpoints = null
    ssh_endpoints  = null
  }
}
