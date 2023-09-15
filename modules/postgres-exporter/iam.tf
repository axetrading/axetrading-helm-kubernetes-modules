

resource "aws_iam_role" "this" {
  count = var.enabled && var.create_role ? 1 : 0

  name        = var.role_name
  name_prefix = module.short-name[0].result
  path        = var.role_path
  description = var.role_description

  assume_role_policy    = data.aws_iam_policy_document.this[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = length(var.role_policy_arns) > 0 && var.create_role && var.enabled ? var.role_policy_arns : []

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}


resource "aws_iam_policy" "secretsmanager_readonly" {
  count = var.create_role && var.enabled ? 1 : 0

  name_prefix = "secretsmanager-readonly-policy-"
  path        = var.role_path

  policy = data.aws_iam_policy_document.secretsmanager_readonly[0].json
}

resource "aws_iam_role_policy_attachment" "secretsmanager_readonly" {
  count = var.create_role && var.enabled ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.secretsmanager_readonly[0].arn
}


module "short-name" {
  count      = var.role_name_prefix != null && var.enabled ? 1 : 0
  source     = "axetrading/short-name/null"
  version    = "1.0.0"
  max_length = 38
  value      = var.role_name_prefix
}