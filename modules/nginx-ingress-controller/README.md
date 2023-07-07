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
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.10.1 |

## Resources

| Name | Type |
|------|------|
| [helm_release.external_secrets_cluster_store](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.monitoring_nginx_ingress_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable nginx-ingress-controller module | `bool` | `false` | no |
| <a name="input_ingress_nginx_target_group_arn"></a> [ingress\_nginx\_target\_group\_arn](#input\_ingress\_nginx\_target\_group\_arn) | ARN of the target group to bind the ingress controller to | `string` | `null` | no |
| <a name="input_nginx_ingress_controller_version"></a> [nginx\_ingress\_controller\_version](#input\_nginx\_ingress\_controller\_version) | nginx-ingress-controller version | `string` | `"4.7.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nginx_ingress_controller"></a> [nginx\_ingress\_controller](#output\_nginx\_ingress\_controller) | Nginx Ingress Controller Release Details |
<!-- END_TF_DOCS -->