//s3 bucket for loki 
resource "aws_s3_bucket" "loki" {
  count = var.create_bucket ? 1 : 0

  bucket = var.loki_bucket_name
  tags = merge({
    Name = var.loki_bucket_name
  }, var.tags)
}
