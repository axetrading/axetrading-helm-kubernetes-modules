# axetrading-helm-kubernetes-modules
This repository contains modules terraform modules for cluster-autoscaler, load-balancer-controller and ingress-controller.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.36 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_blackbox_exporter"></a> [blackbox\_exporter](#module\_blackbox\_exporter) | ./modules/blackbox-exporter | n/a |
| <a name="module_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#module\_eks\_cluster\_autoscaler) | ./modules/cluster-autoscaler | n/a |
| <a name="module_kube-prometheus-stack"></a> [kube-prometheus-stack](#module\_kube-prometheus-stack) | ./modules/kube-prometheus-stack | n/a |
| <a name="module_loki_stack"></a> [loki\_stack](#module\_loki\_stack) | ./modules/loki-stack | n/a |
| <a name="module_nginx_ingress_controller"></a> [nginx\_ingress\_controller](#module\_nginx\_ingress\_controller) | ./modules/nginx-ingress-controller | n/a |
| <a name="module_postgres_exporter"></a> [postgres\_exporter](#module\_postgres\_exporter) | ./modules/postgres-exporter | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_statsd_exporter"></a> [statsd\_exporter](#module\_statsd\_exporter) | ./modules/statsd-exporter | n/a |
| <a name="module_thanos"></a> [thanos](#module\_thanos) | ./modules/thanos | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alertmanager_external_url"></a> [alertmanager\_external\_url](#input\_alertmanager\_external\_url) | The Alertmanager external URL | `string` | `null` | no |
| <a name="input_alertmanager_target_group_arn"></a> [alertmanager\_target\_group\_arn](#input\_alertmanager\_target\_group\_arn) | ARN of the target group for Alertmanager | `string` | `null` | no |
| <a name="input_attach_grafana_cloudwatch_policy"></a> [attach\_grafana\_cloudwatch\_policy](#input\_attach\_grafana\_cloudwatch\_policy) | Whether to attach the Grafana CloudWatch policy to the IAM role | `bool` | `true` | no |
| <a name="input_blackbox_exporter_host"></a> [blackbox\_exporter\_host](#input\_blackbox\_exporter\_host) | Prometheus Blackbox Exporter host | `string` | `"prometheus-blackbox-exporter.monitoring.svc.cluster.local"` | no |
| <a name="input_blackbox_monitored_endpoints"></a> [blackbox\_monitored\_endpoints](#input\_blackbox\_monitored\_endpoints) | The endpoints to be monitored by Prometheus | <pre>object({<br>    http_endpoints = optional(list(object({<br>      name     = string<br>      url      = string<br>      interval = optional(string, "15s")<br>      timeout  = optional(string, "10s")<br>    })), null)<br>    tcp_endpoints = optional(list(object({<br>      name     = string<br>      url      = string<br>      interval = optional(string, "15s")<br>      timeout  = optional(string, "10s")<br>    })), null)<br>    icmp_endpoints = optional(list(object({<br>      name     = string<br>      url      = string<br>      interval = optional(string, "15s")<br>      timeout  = optional(string, "10s")<br>    })), null)<br>    ssh_endpoints = optional(list(object({<br>      name     = string<br>      url      = string<br>      interval = optional(string, "15s")<br>      timeout  = optional(string, "10s")<br>    })), null)<br>  })</pre> | <pre>{<br>  "http_endpoints": null,<br>  "icmp_endpoints": null,<br>  "ssh_endpoints": null,<br>  "tcp_endpoints": null<br>}</pre> | no |
| <a name="input_bucket_region"></a> [bucket\_region](#input\_bucket\_region) | S3 Region of the Loki bucket | `string` | `"eu-west-2"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_create_loki_bucket"></a> [create\_loki\_bucket](#input\_create\_loki\_bucket) | Whether to create the Loki bucket | `bool` | `true` | no |
| <a name="input_create_thanos_bucket"></a> [create\_thanos\_bucket](#input\_create\_thanos\_bucket) | Whether to create the Thanos bucket | `bool` | `false` | no |
| <a name="input_datasource_secrets"></a> [datasource\_secrets](#input\_datasource\_secrets) | The secrets for the Prometheus Postgres Exporter datasource | `map(string)` | <pre>{<br>  "secret_key": "",<br>  "secret_name": ""<br>}</pre> | no |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | ARN of the OIDC provider associated with the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_alertmanager"></a> [enable\_alertmanager](#input\_enable\_alertmanager) | Whether to enable the alertmanager module | `bool` | `false` | no |
| <a name="input_enable_blackbox_exporter"></a> [enable\_blackbox\_exporter](#input\_enable\_blackbox\_exporter) | Whether to enable the blackbox exporter module | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Whether to enable the cluster autoscaler module | `bool` | `false` | no |
| <a name="input_enable_default_prometheus_rules"></a> [enable\_default\_prometheus\_rules](#input\_enable\_default\_prometheus\_rules) | Whether to enable the default Prometheus rules | `bool` | `false` | no |
| <a name="input_enable_kube_prometheus_stack"></a> [enable\_kube\_prometheus\_stack](#input\_enable\_kube\_prometheus\_stack) | Whether to enable the kube-prometheus-stack module | `bool` | `false` | no |
| <a name="input_enable_loki"></a> [enable\_loki](#input\_enable\_loki) | Whether to enable the loki stack module | `bool` | `false` | no |
| <a name="input_enable_loki_gateway"></a> [enable\_loki\_gateway](#input\_enable\_loki\_gateway) | Whether to enable the Loki gateway module | `bool` | `false` | no |
| <a name="input_enable_nginx_ingress_controller"></a> [enable\_nginx\_ingress\_controller](#input\_enable\_nginx\_ingress\_controller) | Whether to enable the nginx ingress controller module | `bool` | `false` | no |
| <a name="input_enable_postgres_exporter"></a> [enable\_postgres\_exporter](#input\_enable\_postgres\_exporter) | Whether to enable postgres exporter | `bool` | `false` | no |
| <a name="input_enable_prometheus"></a> [enable\_prometheus](#input\_enable\_prometheus) | Whether to enable the prometheus module | `bool` | `false` | no |
| <a name="input_enable_prometheus_alertmanager"></a> [enable\_prometheus\_alertmanager](#input\_enable\_prometheus\_alertmanager) | Whether to enable the prometheus alertmanager module | `bool` | `false` | no |
| <a name="input_enable_prometheus_gateway"></a> [enable\_prometheus\_gateway](#input\_enable\_prometheus\_gateway) | Whether to enable the prometheus gateway module | `bool` | `false` | no |
| <a name="input_enable_promtail"></a> [enable\_promtail](#input\_enable\_promtail) | Whether to enable the promtail module | `bool` | `false` | no |
| <a name="input_enable_statsd_exporter"></a> [enable\_statsd\_exporter](#input\_enable\_statsd\_exporter) | Whether to enable the statsd exporter module | `bool` | `false` | no |
| <a name="input_enable_thanos"></a> [enable\_thanos](#input\_enable\_thanos) | Whether to enable the thanos module | `bool` | `false` | no |
| <a name="input_enable_thanos_external_service"></a> [enable\_thanos\_external\_service](#input\_enable\_thanos\_external\_service) | Whether to enable the thanos sidecar external service | `bool` | `false` | no |
| <a name="input_enable_thanos_gateway"></a> [enable\_thanos\_gateway](#input\_enable\_thanos\_gateway) | Whether to enable the thanos gateway module | `bool` | `false` | no |
| <a name="input_enable_thanos_receiver"></a> [enable\_thanos\_receiver](#input\_enable\_thanos\_receiver) | Whether to enable the thanos receiver module | `bool` | `false` | no |
| <a name="input_enable_thanos_sidecar"></a> [enable\_thanos\_sidecar](#input\_enable\_thanos\_sidecar) | Whether to enable the thanos sidecar module | `bool` | `false` | no |
| <a name="input_ingress_nginx_target_group_arn"></a> [ingress\_nginx\_target\_group\_arn](#input\_ingress\_nginx\_target\_group\_arn) | ARN of the target group to bind the ingress controller to | `string` | `null` | no |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | Name of the Kubernetes cluster where Prometheus Stack is going to be deployed | `string` | n/a | yes |
| <a name="input_loki_bucket_name"></a> [loki\_bucket\_name](#input\_loki\_bucket\_name) | Name of the Loki bucket | `string` | `"axetrading-loki"` | no |
| <a name="input_loki_existing_bucket_name"></a> [loki\_existing\_bucket\_name](#input\_loki\_existing\_bucket\_name) | Name of an existing S3 bucket for Loki | `string` | `null` | no |
| <a name="input_loki_gateway_target_group_arn"></a> [loki\_gateway\_target\_group\_arn](#input\_loki\_gateway\_target\_group\_arn) | ARN of the target group for Loki Gateway | `string` | `null` | no |
| <a name="input_monitored_endpoints"></a> [monitored\_endpoints](#input\_monitored\_endpoints) | The endpoints to be monitored by Prometheus | <pre>object({<br>    http_endpoints = optional(list(string), null)<br>    tcp_endpoints  = optional(list(string), null)<br>    icmp_endpoints = optional(list(string), null)<br>    ssh_endpoints  = optional(list(string), null)<br>  })</pre> | <pre>{<br>  "http_endpoints": null,<br>  "icmp_endpoints": null,<br>  "ssh_endpoints": null,<br>  "tcp_endpoints": null<br>}</pre> | no |
| <a name="input_monitoring_aws_account_id"></a> [monitoring\_aws\_account\_id](#input\_monitoring\_aws\_account\_id) | AWS account ID where the monitoring stack is deployed | `string` | n/a | yes |
| <a name="input_pagerduty_service_key"></a> [pagerduty\_service\_key](#input\_pagerduty\_service\_key) | The PagerDuty service key where the alerts will be sent | `string` | `null` | no |
| <a name="input_pagerduty_url"></a> [pagerduty\_url](#input\_pagerduty\_url) | The PagerDuty URL where the alerts will be sent | `string` | `null` | no |
| <a name="input_prometheus_default_rules"></a> [prometheus\_default\_rules](#input\_prometheus\_default\_rules) | A map of Prometheus default rules | `map(any)` | `null` | no |
| <a name="input_prometheus_endpoint"></a> [prometheus\_endpoint](#input\_prometheus\_endpoint) | AWS Managed Prometheus endpoint URL | `string` | n/a | yes |
| <a name="input_prometheus_evaluation_interval"></a> [prometheus\_evaluation\_interval](#input\_prometheus\_evaluation\_interval) | The evaluation interval for Prometheus | `string` | `"1m"` | no |
| <a name="input_prometheus_external_url"></a> [prometheus\_external\_url](#input\_prometheus\_external\_url) | The Prometheus external URL | `string` | `null` | no |
| <a name="input_prometheus_gateway_target_group_arn"></a> [prometheus\_gateway\_target\_group\_arn](#input\_prometheus\_gateway\_target\_group\_arn) | ARN of the target group for Prometheus Gateway | `string` | `null` | no |
| <a name="input_prometheus_scrape_interval"></a> [prometheus\_scrape\_interval](#input\_prometheus\_scrape\_interval) | The scrape interval for Prometheus | `string` | `"15s"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_slack_api_url"></a> [slack\_api\_url](#input\_slack\_api\_url) | The Slack Channel API URL where the alerts will be sent | `string` | `null` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The Slack Channel where the alerts will be sent | `string` | `"monitoring"` | no |
| <a name="input_stat_statements_enabled"></a> [stat\_statements\_enabled](#input\_stat\_statements\_enabled) | Whether to enable collection of extended statistics from PostgreSQL | `bool` | `false` | no |
| <a name="input_thanos_bucket_name"></a> [thanos\_bucket\_name](#input\_thanos\_bucket\_name) | Name of the Thanos bucket | `string` | `null` | no |
| <a name="input_thanos_bucket_region"></a> [thanos\_bucket\_region](#input\_thanos\_bucket\_region) | S3 Region of the Thanos bucket | `string` | `"eu-west-2"` | no |
| <a name="input_thanos_existing_bucket_name"></a> [thanos\_existing\_bucket\_name](#input\_thanos\_existing\_bucket\_name) | Name of an existing S3 bucket for Thanos | `string` | `null` | no |
| <a name="input_thanos_gateway_target_group_arn"></a> [thanos\_gateway\_target\_group\_arn](#input\_thanos\_gateway\_target\_group\_arn) | ARN of the target group for Thanos Gateway | `string` | `null` | no |
| <a name="input_thanos_query_autoscaling_enabled"></a> [thanos\_query\_autoscaling\_enabled](#input\_thanos\_query\_autoscaling\_enabled) | Whether to enable autoscaling for Thanos Query | `bool` | `false` | no |
| <a name="input_thanos_query_autoscaling_max_replicas"></a> [thanos\_query\_autoscaling\_max\_replicas](#input\_thanos\_query\_autoscaling\_max\_replicas) | Maximum number of replicas for Thanos Query autoscaling | `number` | `10` | no |
| <a name="input_thanos_query_autoscaling_min_replicas"></a> [thanos\_query\_autoscaling\_min\_replicas](#input\_thanos\_query\_autoscaling\_min\_replicas) | Minimum number of replicas for Thanos Query autoscaling | `number` | `2` | no |
| <a name="input_thanos_query_autoscaling_target_cpu_utilization_percentage"></a> [thanos\_query\_autoscaling\_target\_cpu\_utilization\_percentage](#input\_thanos\_query\_autoscaling\_target\_cpu\_utilization\_percentage) | Target CPU utilization percentage for Thanos Query autoscaling | `number` | `80` | no |
| <a name="input_thanos_query_autoscaling_target_memory_utilization_percentage"></a> [thanos\_query\_autoscaling\_target\_memory\_utilization\_percentage](#input\_thanos\_query\_autoscaling\_target\_memory\_utilization\_percentage) | Target memory utilization percentage for Thanos Query autoscaling | `number` | `80` | no |
| <a name="input_thanos_query_resources_limits_memory"></a> [thanos\_query\_resources\_limits\_memory](#input\_thanos\_query\_resources\_limits\_memory) | Memory limits for Thanos Query | `string` | `"256Mi"` | no |
| <a name="input_thanos_query_resources_requests_cpu"></a> [thanos\_query\_resources\_requests\_cpu](#input\_thanos\_query\_resources\_requests\_cpu) | CPU requests for Thanos Query | `string` | `"100m"` | no |
| <a name="input_thanos_query_resources_requests_memory"></a> [thanos\_query\_resources\_requests\_memory](#input\_thanos\_query\_resources\_requests\_memory) | Memory requests for Thanos Query | `string` | `"256Mi"` | no |
| <a name="input_thanos_receiver_remote_write_port"></a> [thanos\_receiver\_remote\_write\_port](#input\_thanos\_receiver\_remote\_write\_port) | Port for Thanos Receiver remote write | `number` | `19291` | no |
| <a name="input_thanos_receiver_target_group_arn"></a> [thanos\_receiver\_target\_group\_arn](#input\_thanos\_receiver\_target\_group\_arn) | ARN of the target group for Thanos Receiver | `string` | `null` | no |
| <a name="input_thanos_sidecar_secret_name"></a> [thanos\_sidecar\_secret\_name](#input\_thanos\_sidecar\_secret\_name) | Name of the Thanos sidecar secret | `string` | `null` | no |
| <a name="input_thanos_sidecar_target_group_arn"></a> [thanos\_sidecar\_target\_group\_arn](#input\_thanos\_sidecar\_target\_group\_arn) | ARN of the target group for Thanos Sidecar | `string` | `null` | no |
| <a name="input_thanos_storegateway_replica_count"></a> [thanos\_storegateway\_replica\_count](#input\_thanos\_storegateway\_replica\_count) | Number of replicas for Thanos Store Gateway | `number` | `2` | no |
| <a name="input_thanos_stores_endpoints"></a> [thanos\_stores\_endpoints](#input\_thanos\_stores\_endpoints) | The endpoints of the Thanos stores | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blackbox_exporter"></a> [blackbox\_exporter](#output\_blackbox\_exporter) | Blackbox Exporter module outputs |
| <a name="output_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#output\_eks\_cluster\_autoscaler) | EKS Cluster Autoscaler module outputs |
| <a name="output_prometheus"></a> [prometheus](#output\_prometheus) | Prometheus module outputs |
| <a name="output_statsd_exporter"></a> [statsd\_exporter](#output\_statsd\_exporter) | StatsD Exporter module outputs |
<!-- END_TF_DOCS -->