terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# S3 Bucket principal
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.environment}-s3"
    Environment = var.environment
  }
}

# Bloqueo de acceso público
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Clave KMS para cifrado de S3
resource "aws_kms_key" "s3" {
  description             = "KMS key for S3 bucket ${var.bucket_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "s3-key-policy",
  "Statement": [
    {
      "Sid": "AllowRootAccount",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
POLICY
}

data "aws_caller_identity" "current" {}

# Cifrado en reposo con KMS por defecto
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3.arn
    }
  }
}

# Logging básico (requiere otro bucket como destino)
resource "aws_s3_bucket_logging" "this" {
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.log_bucket_name
  target_prefix = "logs/"
}

# Versionado obligatorio
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Ciclo de vida mínimo (expiración + abortar cargas incompletas)
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter { prefix = "" }

    expiration { days = 30 }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# Rol IAM para replicación
resource "aws_iam_role" "replication" {
  name = "${var.environment}-s3-replication-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Replicación entre regiones
resource "aws_s3_bucket_replication_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  role   = aws_iam_role.replication.arn

  rule {
    id     = "replication"
    status = "Enabled"

    destination {
      bucket        = "arn:aws:s3:::${var.replication_bucket}"
      storage_class = "STANDARD"
    }
  }
}

# SNS Topic para notificaciones
resource "aws_sns_topic" "s3_events" {
  name = "${var.environment}-s3-events"
}

# Notificaciones de eventos
resource "aws_s3_bucket_notification" "this" {
  bucket = aws_s3_bucket.this.id

  topic {
    topic_arn = aws_sns_topic.s3_events.arn
    events    = ["s3:ObjectCreated:*"]
  }
}

