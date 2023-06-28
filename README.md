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
| <a name="module_nginx_ingress_controller"></a> [nginx\_ingress\_controller](#module\_nginx\_ingress\_controller) | ./modules/nginx-ingress-controller | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_statsd_exporter"></a> [statsd\_exporter](#module\_statsd\_exporter) | ./modules/statsd-exporter | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_grafana_cloudwatch_policy"></a> [attach\_grafana\_cloudwatch\_policy](#input\_attach\_grafana\_cloudwatch\_policy) | Whether to attach the Grafana CloudWatch policy to the IAM role | `bool` | `true` | no |
| <a name="input_blackbox_exporter_host"></a> [blackbox\_exporter\_host](#input\_blackbox\_exporter\_host) | Prometheus Blackbox Exporter host | `string` | `"prometheus-blackbox-exporter.monitoring.svc.cluster.local"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | ARN of the OIDC provider associated with the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_blackbox_exporter"></a> [enable\_blackbox\_exporter](#input\_enable\_blackbox\_exporter) | Whether to enable the blackbox exporter module | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Whether to enable the cluster autoscaler module | `bool` | `false` | no |
| <a name="input_enable_nginx_ingress_controller"></a> [enable\_nginx\_ingress\_controller](#input\_enable\_nginx\_ingress\_controller) | Whether to enable the nginx ingress controller module | `bool` | `false` | no |
| <a name="input_enable_prometheus"></a> [enable\_prometheus](#input\_enable\_prometheus) | Whether to enable the prometheus module | `bool` | `false` | no |
| <a name="input_enable_statsd_exporter"></a> [enable\_statsd\_exporter](#input\_enable\_statsd\_exporter) | Whether to enable the statsd exporter module | `bool` | `false` | no |
| <a name="input_monitored_endpoints"></a> [monitored\_endpoints](#input\_monitored\_endpoints) | The endpoints to be monitored by Prometheus | <pre>object({<br>    http_endpoints = optional(list(string), null)<br>    tcp_endpoints  = optional(list(string), null)<br>    icmp_endpoints = optional(list(string), null)<br>    ssh_endpoints  = optional(list(string), null)<br>  })</pre> | <pre>{<br>  "http_endpoints": null,<br>  "icmp_endpoints": null,<br>  "ssh_endpoints": null,<br>  "tcp_endpoints": null<br>}</pre> | no |
| <a name="input_monitoring_aws_account_id"></a> [monitoring\_aws\_account\_id](#input\_monitoring\_aws\_account\_id) | AWS account ID where the monitoring stack is deployed | `string` | n/a | yes |
| <a name="input_prometheus_endpoint"></a> [prometheus\_endpoint](#input\_prometheus\_endpoint) | AWS Managed Prometheus endpoint URL | `string` | n/a | yes |
| <a name="input_prometheus_evaluation_interval"></a> [prometheus\_evaluation\_interval](#input\_prometheus\_evaluation\_interval) | The evaluation interval for Prometheus | `string` | `"1m"` | no |
| <a name="input_prometheus_scrape_interval"></a> [prometheus\_scrape\_interval](#input\_prometheus\_scrape\_interval) | The scrape interval for Prometheus | `string` | `"15s"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blackbox_exporter"></a> [blackbox\_exporter](#output\_blackbox\_exporter) | Blackbox Exporter module outputs |
| <a name="output_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#output\_eks\_cluster\_autoscaler) | EKS Cluster Autoscaler module outputs |
| <a name="output_prometheus"></a> [prometheus](#output\_prometheus) | Prometheus module outputs |
| <a name="output_statsd_exporter"></a> [statsd\_exporter](#output\_statsd\_exporter) | StatsD Exporter module outputs |
<!-- END_TF_DOCS -->