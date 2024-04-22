data "aws_iam_policy_document" "loki" {
  count = var.create_role ? 1 : 0

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.loki[0].arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.loki[0].arn}/*",
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

resource "aws_iam_policy" "loki" {
  count = var.create_role ? 1 : 0

  name_prefix = "amp-prometheus-ingest-policy-"
  path        = var.role_path
  description = "Policy for Prometheus"
  policy      = data.aws_iam_policy_document.loki[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "loki" {
  count = var.create_role ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.loki[0].arn
}