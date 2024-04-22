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
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_short-name"></a> [short-name](#module\_short-name) | axetrading/short-name/null | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.loki](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.loki](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.loki](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [helm_release.grafana_agent_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.loki_targetgroupbinding_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.loki](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_value_files"></a> [additional\_value\_files](#input\_additional\_value\_files) | A list of additional value files. It will work in the same way as helm -f value1.yaml -f value2.yaml | `list(any)` | `[]` | no |
| <a name="input_assume_role_condition_test"></a> [assume\_role\_condition\_test](#input\_assume\_role\_condition\_test) | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| <a name="input_attach_secrets_policy"></a> [attach\_secrets\_policy](#input\_attach\_secrets\_policy) | Attach a policy that will allow the role to get secrets from AWS Secrets Manager or AWS SSM | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of an existing S3 bucket for Loki | `string` | `null` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Create S3 bucket for Loki | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Whether to create a service account for Kubernetes Deployment | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the cluster autoscaler | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `null` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_grafana_agent_operator_version"></a> [grafana\_agent\_operator\_version](#input\_grafana\_agent\_operator\_version) | Grafana Agent Operator helm chart version | `string` | `"0.2.16"` | no |
| <a name="input_loki_bucket_name"></a> [loki\_bucket\_name](#input\_loki\_bucket\_name) | Name of the S3 bucket that will be created for Loki | `string` | `"axetrading-loki"` | no |
| <a name="input_loki_gateway_enabled"></a> [loki\_gateway\_enabled](#input\_loki\_gateway\_enabled) | Whether to enable Loki Gateway | `bool` | `true` | no |
| <a name="input_loki_gateway_target_group_arn"></a> [loki\_gateway\_target\_group\_arn](#input\_loki\_gateway\_target\_group\_arn) | ARN of the target group for Loki Gateway | `string` | `null` | no |
| <a name="input_loki_object_store_type"></a> [loki\_object\_store\_type](#input\_loki\_object\_store\_type) | Type of object store to use for Loki | `string` | `"s3"` | no |
| <a name="input_loki_version"></a> [loki\_version](#input\_loki\_version) | Loki-stack helm chart version | `string` | `"5.8.6"` | no |
| <a name="input_loki_write_persistence_enabled"></a> [loki\_write\_persistence\_enabled](#input\_loki\_write\_persistence\_enabled) | Whether to enable Loki write persistence | `bool` | `true` | no |
| <a name="input_loki_write_persistence_size"></a> [loki\_write\_persistence\_size](#input\_loki\_write\_persistence\_size) | Size of the Loki write persistence volume | `string` | `"10Gi"` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts` | `any` | `{}` | no |
| <a name="input_policy_name_prefix"></a> [policy\_name\_prefix](#input\_policy\_name\_prefix) | IAM policy name prefix | `string` | `"eks-policy"` | no |
| <a name="input_promtail_enabled"></a> [promtail\_enabled](#input\_promtail\_enabled) | Whether to enable promtail | `bool` | `true` | no |
| <a name="input_promtail_version"></a> [promtail\_version](#input\_promtail\_version) | Promtail helm chart version | `string` | `"6.11.5"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Existing role ARN | `string` | `null` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role for Prometheus |
| <a name="output_loki"></a> [loki](#output\_loki) | Loki Release Details |
| <a name="output_promtail"></a> [promtail](#output\_promtail) | Promtail Release Details |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 Bucket ID |
<!-- END_TF_DOCS -->