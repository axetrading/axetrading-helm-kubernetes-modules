data "aws_iam_policy_document" "thanos" {
  count = var.create_role ? 1 : 0

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.thanos[0].arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:Get*",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.thanos[0].arn}/*",
    ]
  }
}

resource "aws_iam_policy" "thanos" {
  count = var.create_role ? 1 : 0

  name_prefix = "thanos-store-policy-"
  path        = var.role_path
  description = "Policy for Thanos StoreGateway"
  policy      = data.aws_iam_policy_document.thanos[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "thanos" {
  count = var.create_role ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.thanos[0].arn
}