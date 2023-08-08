config:
  modules:
    http_post_2xx:
      prober: http
      http:
        method: POST
        preferred_ip_protocol: "ip4" # defaults to "ip6"
        ip_protocol_fallback: false  # no fallback to "ip6"
    tcp_connect:
      prober: tcp
    ssh_banner:
      prober: tcp
      tcp:
        query_response:
        - expect: "^SSH-2.0-"
    icmp:
      prober: icmp

serviceMonitor:
  targets:
  %{~ if monitored_endpoints.http_endpoints != null ~}
  %{~ for http_endpoint in monitored_endpoints.http_endpoints ~}
     - name: ${http_endpoint.name}
       url: ${http_endpoint.url}
       interval: ${http_endpoint.interval}
       timeout: ${http_endpoint.timeout}
       module: http_2xx
  %{~ endfor ~}
  %{~ endif ~} 
  %{~ if monitored_endpoints.tcp_endpoints != null ~}
  %{~ for tcp_endpoints in monitored_endpoints.tcp_endpoints ~}
     - name: ${tcp_endpoints.name}
       url: ${tcp_endpoints.url}
       interval: ${tcp_endpoints.interval}
       timeout: ${tcp_endpoints.timeout}
       module: tcp_connect
  %{~ endfor ~}
  %{~ endif ~}
  %{~ if monitored_endpoints.ssh_endpoints != null ~}
  %{~ for ssh_endpoints in monitored_endpoints.ssh_endpoints ~}
     - name: ${ssh_endpoints.name}
       url: ${ssh_endpoints.url}
       interval: ${ssh_endpoints.interval}
       timeout: ${ssh_endpoints.timeout}
       module: ssh_banner
  %{~ endfor ~}
  %{~ endif ~}
  %{~ if monitored_endpoints.icmp_endpoints != null ~}
  %{~ for icmp_endpoints in monitored_endpoints.icmp_endpoints ~}
     - name: ${icmp_endpoints.name}
       url: ${icmp_endpoints.url}
       interval: ${icmp_endpoints.interval}
       timeout: ${icmp_endpoints.timeout}
       module: icmp
  %{~ endfor ~}
  %{~ endif ~}