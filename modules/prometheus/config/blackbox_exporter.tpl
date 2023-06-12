extraScrapeConfigs:
  %{~ if monitored_endpoints.http_endpoints != null ~}
  - job_name: 'blackbox-http'
    metrics_path: /probe
    params:
      module: [http_2xx]
    static_configs:
      - targets:
      %{~ for http_endpoints in monitored_endpoints.http_endpoints ~}
        - ${http_endpoints}
      %{~ endfor ~}
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: ${blackbox_exporter_host} 
  %{~ endif ~}
  %{~ if monitored_endpoints.tcp_endpoints != null ~}
  - job_name: 'blackbox-tcp'
    metrics_path: /probe
    params:
      module: [tcp_connect]
    static_configs:
      - targets:
      %{~ for tcp_endpoints in monitored_endpoints.tcp_endpoints ~}
        - ${tcp_endpoints}
      %{~ endfor ~}
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: ${blackbox_exporter_host} 
  %{~ endif ~}
  %{~ if monitored_endpoints.icmp_endpoints != null ~}
  - job_name: 'blackbox-icmp'
    metrics_path: /probe
    params:
      module: [icmp]
    static_configs:
      - targets:
      %{~ for icmp_endpoints in monitored_endpoints.icmp_endpoints ~}
        - ${icmp_endpoints}
      %{~ endfor ~}
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: ${blackbox_exporter_host} 
  %{~ endif ~}
  %{~ if monitored_endpoints.ssh_endpoints != null ~}
  - job_name: 'blackbox-ssh'
    metrics_path: /probe
    params:
      module: [ssh_banner]
    static_configs:
      - targets:
      %{~ for ssh_endpoints in monitored_endpoints.ssh_endpoints ~}
        - ${ssh_endpoints}
      %{~ endfor ~}
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: ${blackbox_exporter_host} 
  %{~ endif ~}
