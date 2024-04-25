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

data "aws_iam_policy_document" "s3_access" {
  count = var.create_role && var.enabled ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.thanos_bucket_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.thanos_bucket_name}/*"
    ]
  }

  statement {
    sid = "AllowKMS"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "secretsmanager_readonly" {
  count = var.create_role && var.enabled ? 1 : 0
  statement {
    sid    = "ThanosSecretsReadOnly"
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
