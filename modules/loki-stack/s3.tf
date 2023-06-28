//s3 bucket for loki 
resource "aws_s3_bucket" "loki" {
  count = var.create_bucket ? 1 : 0

  bucket = "axetrading-loki"
  tags = merge({
    Name = "axetrading-loki"
  }, var.tags)
}

resource "aws_s3_bucket_acl" "loki" {
  count = var.create_bucket ? 1 : 0

  bucket = aws_s3_bucket.loki[0].id
  acl    = "private"
}