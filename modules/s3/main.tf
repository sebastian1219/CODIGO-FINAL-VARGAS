# 1. El bucket principal
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.environment}-s3"
    Environment = var.environment
  }
}

# 2. Versionado habilitado
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Cifrado en reposo
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

