//s3 bucket for thanos 
resource "aws_s3_bucket" "thanos" {
  count = var.create_bucket && var.enabled ? 1 : 0

  bucket = var.thanos_bucket_name
  tags = merge({
    Name = var.thanos_bucket_name
  }, var.tags)
}
