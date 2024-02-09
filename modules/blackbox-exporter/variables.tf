variable "enabled" {
  description = "Enable blackbox-exporter"
  type        = bool
  default     = true
}

variable "blackbox_exporter_version" {
  type        = string
  description = "Version of the blackbox-exporter Helm chart"
  default     = "8.10.1"
}

variable "monitored_endpoints" {
  description = "The endpoints to be monitored by Prometheus"
  type = object({
    http_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    tcp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    icmp_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
    ssh_endpoints = optional(list(object({
      name     = string
      url      = string
      interval = optional(string, "15s")
      timeout  = optional(string, "10s")
    })), null)
  })
  default = {
    http_endpoints = null
    tcp_endpoints  = null
    icmp_endpoints = null
    ssh_endpoints  = null
  }
}
