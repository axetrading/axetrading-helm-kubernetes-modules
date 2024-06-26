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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.10.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_short-name"></a> [short-name](#module\_short-name) | axetrading/short-name/null | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.thanos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.thanos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.thanos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [helm_release.thanos](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.thanos_receiver_targetgroupbinding_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.thanos_targetgroupbinding_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.thanos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_value_files"></a> [additional\_value\_files](#input\_additional\_value\_files) | A list of additional value files. It will work in the same way as helm -f value1.yaml -f value2.yaml | `list(any)` | `[]` | no |
| <a name="input_assume_role_condition_test"></a> [assume\_role\_condition\_test](#input\_assume\_role\_condition\_test) | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| <a name="input_attach_secrets_policy"></a> [attach\_secrets\_policy](#input\_attach\_secrets\_policy) | Attach a policy that will allow the role to get secrets from AWS Secrets Manager or AWS SSM | `bool` | `true` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Create S3 bucket for Thanos | `bool` | `false` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Whether to create a service account for Kubernetes Deployment | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create Thanos resources or not | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `null` | no |
| <a name="input_existing_bucket_name"></a> [existing\_bucket\_name](#input\_existing\_bucket\_name) | Name of the an existing S3 bucket that will be used by Thanos | `string` | `null` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts` | `any` | `{}` | no |
| <a name="input_policy_name_prefix"></a> [policy\_name\_prefix](#input\_policy\_name\_prefix) | IAM policy name prefix | `string` | `"eks-policy"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Existing role ARN | `string` | `null` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |
| <a name="input_thanos_bucket_name"></a> [thanos\_bucket\_name](#input\_thanos\_bucket\_name) | Name of the S3 bucket that will be created for Thanos | `string` | `null` | no |
| <a name="input_thanos_bucket_region"></a> [thanos\_bucket\_region](#input\_thanos\_bucket\_region) | Region of the S3 bucket that will be created for Thanos | `string` | `"eu-west-2"` | no |
| <a name="input_thanos_compactor_retention_resolution_1h"></a> [thanos\_compactor\_retention\_resolution\_1h](#input\_thanos\_compactor\_retention\_resolution\_1h) | Retention resolution 1h for Thanos Compactor | `string` | `"180d"` | no |
| <a name="input_thanos_compactor_retention_resolution_5m"></a> [thanos\_compactor\_retention\_resolution\_5m](#input\_thanos\_compactor\_retention\_resolution\_5m) | Retention resolution 5m for Thanos Compactor | `string` | `"30d"` | no |
| <a name="input_thanos_compactor_retention_resolution_raw"></a> [thanos\_compactor\_retention\_resolution\_raw](#input\_thanos\_compactor\_retention\_resolution\_raw) | Retention resolution raw for Thanos Compactor | `string` | `"30d"` | no |
| <a name="input_thanos_gateway_enabled"></a> [thanos\_gateway\_enabled](#input\_thanos\_gateway\_enabled) | Whether to enable Thanos Gateway | `bool` | `true` | no |
| <a name="input_thanos_gateway_target_group_arn"></a> [thanos\_gateway\_target\_group\_arn](#input\_thanos\_gateway\_target\_group\_arn) | ARN of the target group for Thanos Gateway | `string` | `null` | no |
| <a name="input_thanos_objstore_endpoint"></a> [thanos\_objstore\_endpoint](#input\_thanos\_objstore\_endpoint) | Endpoint of the S3 bucket that will be created for Thanos | `string` | `"s3.eu-west-2.amazonaws.com"` | no |
| <a name="input_thanos_query_autoscaling_enabled"></a> [thanos\_query\_autoscaling\_enabled](#input\_thanos\_query\_autoscaling\_enabled) | Whether to enable autoscaling for Thanos Query | `bool` | `false` | no |
| <a name="input_thanos_query_autoscaling_max_replicas"></a> [thanos\_query\_autoscaling\_max\_replicas](#input\_thanos\_query\_autoscaling\_max\_replicas) | Maximum number of replicas for Thanos Query autoscaling | `number` | `10` | no |
| <a name="input_thanos_query_autoscaling_min_replicas"></a> [thanos\_query\_autoscaling\_min\_replicas](#input\_thanos\_query\_autoscaling\_min\_replicas) | Minimum number of replicas for Thanos Query autoscaling | `number` | `2` | no |
| <a name="input_thanos_query_autoscaling_target_cpu_utilization_percentage"></a> [thanos\_query\_autoscaling\_target\_cpu\_utilization\_percentage](#input\_thanos\_query\_autoscaling\_target\_cpu\_utilization\_percentage) | Target CPU utilization percentage for Thanos Query autoscaling | `number` | `80` | no |
| <a name="input_thanos_query_autoscaling_target_memory_utilization_percentage"></a> [thanos\_query\_autoscaling\_target\_memory\_utilization\_percentage](#input\_thanos\_query\_autoscaling\_target\_memory\_utilization\_percentage) | Target memory utilization percentage for Thanos Query autoscaling | `number` | `80` | no |
| <a name="input_thanos_query_resources_limits_memory"></a> [thanos\_query\_resources\_limits\_memory](#input\_thanos\_query\_resources\_limits\_memory) | Memory limits for Thanos Query | `string` | `"256Mi"` | no |
| <a name="input_thanos_query_resources_requests_cpu"></a> [thanos\_query\_resources\_requests\_cpu](#input\_thanos\_query\_resources\_requests\_cpu) | CPU requests for Thanos Query | `string` | `"100m"` | no |
| <a name="input_thanos_query_resources_requests_memory"></a> [thanos\_query\_resources\_requests\_memory](#input\_thanos\_query\_resources\_requests\_memory) | Memory requests for Thanos Query | `string` | `"256Mi"` | no |
| <a name="input_thanos_receiver_enabled"></a> [thanos\_receiver\_enabled](#input\_thanos\_receiver\_enabled) | Whether to enable Thanos Receiver | `bool` | `false` | no |
| <a name="input_thanos_receiver_remote_write_port"></a> [thanos\_receiver\_remote\_write\_port](#input\_thanos\_receiver\_remote\_write\_port) | Port for Thanos Receiver remote write | `number` | `19291` | no |
| <a name="input_thanos_receiver_target_group_arn"></a> [thanos\_receiver\_target\_group\_arn](#input\_thanos\_receiver\_target\_group\_arn) | ARN of the target group for Thanos Receiver | `string` | `null` | no |
| <a name="input_thanos_storegateway_replica_count"></a> [thanos\_storegateway\_replica\_count](#input\_thanos\_storegateway\_replica\_count) | Number of replicas for Thanos Store Gateway | `number` | `2` | no |
| <a name="input_thanos_stores_endpoints"></a> [thanos\_stores\_endpoints](#input\_thanos\_stores\_endpoints) | Endpoints of Thanos Stores (Gateways or SideCars, Rulers) that will be attached to Thanos Query | `list(string)` | `null` | no |
| <a name="input_thanos_version"></a> [thanos\_version](#input\_thanos\_version) | Thanos-stack helm chart version | `string` | `"5.8.6"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role for Thanos |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 Bucket ID |
| <a name="output_thanos"></a> [thanos](#output\_thanos) | Loki Release Details |
<!-- END_TF_DOCS -->