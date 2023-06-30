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

## Resources

| Name | Type |
|------|------|
| [helm_release.blackbox_exporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blackbox_exporter_version"></a> [blackbox\_exporter\_version](#input\_blackbox\_exporter\_version) | Version of the blackbox-exporter Helm chart | `string` | `"7.10.0"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable blackbox-exporter | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blackbox_exporter"></a> [blackbox\_exporter](#output\_blackbox\_exporter) | Blackbox Exporter Release Details |
<!-- END_TF_DOCS -->