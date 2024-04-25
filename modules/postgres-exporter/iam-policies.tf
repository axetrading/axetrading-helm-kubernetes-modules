data "aws_iam_policy_document" "this" {
  count = var.create_role && var.enabled ? 1 : 0

  dynamic "statement" {
    for_each = var.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:sub"
        values   = [for sa in statement.value.namespace_service_accounts : "system:serviceaccount:${sa}"]
      }
      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }

    }
  }
}

data "aws_iam_policy_document" "secretsmanager_readonly" {
  count = var.create_role && var.enabled ? 1 : 0
  statement {
    sid    = "PGExporterSecretsReadOnly"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:ListSecrets"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt*",
      "kms:Encrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:GetKeyRotationStatus*",
      "kms:GetKeyPolicy*",
      "kms:DescribeKey*",
    ]
    resources = ["*"]
  }
}
