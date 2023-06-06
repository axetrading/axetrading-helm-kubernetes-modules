data "aws_iam_policy_document" "prometheus" {
  statement {
    sid    = "AssumeAMPRemoteWriteRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::${var.monitoring_account_id}:role/EKS-AMP-Central-Role",
    ]
  }
}

resource "aws_iam_policy" "prometheus" {
  count = var.create_role ? 1 : 0

  name_prefix = "amp-prometheus-ingest-policy-"
  path        = var.role_path
  description = "Policy for Prometheus"
  policy      = data.aws_iam_policy_document.prometheus.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "prometheus" {
  count = var.create_role ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.prometheus[0].arn
}