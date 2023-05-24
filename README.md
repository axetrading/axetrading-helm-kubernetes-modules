# axetrading-helm-kubernetes-modules
This repository contains modules terraform modules for cluster-autoscaler, load-balancer-controller and ingress-controller.

<!-- BEGIN_TF_DOCS -->


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#module\_eks\_cluster\_autoscaler) | ./modules/cluster-autoscaler | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | ARN of the OIDC provider associated with the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Whether to enable the cluster autoscaler module | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_autoscaler"></a> [eks\_cluster\_autoscaler](#output\_eks\_cluster\_autoscaler) | EKS Cluster Autoscaler module outputs |
<!-- END_TF_DOCS -->