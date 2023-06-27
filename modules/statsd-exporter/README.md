<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.36 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.10.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.statsd_exporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable statsd-exporter | `bool` | `false` | no |
| <a name="input_statsd_exporter_target_group_arn"></a> [statsd\_exporter\_target\_group\_arn](#input\_statsd\_exporter\_target\_group\_arn) | ARN of the target group to attach the statsd-exporter to | `string` | `null` | no |
| <a name="input_statsd_exporter_version"></a> [statsd\_exporter\_version](#input\_statsd\_exporter\_version) | Version of the statsd-exporter Helm chart | `string` | `"0.8.0"` | no |
| <a name="input_statsd_high_availability_enabled"></a> [statsd\_high\_availability\_enabled](#input\_statsd\_high\_availability\_enabled) | Enable high availability for statsd-exporter | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release_id"></a> [helm\_release\_id](#output\_helm\_release\_id) | Helm Release ID |
| <a name="output_helm_release_name"></a> [helm\_release\_name](#output\_helm\_release\_name) | Helm Release Name |
| <a name="output_helm_release_namespace"></a> [helm\_release\_namespace](#output\_helm\_release\_namespace) | Helm Release Namespace |
<!-- END_TF_DOCS -->