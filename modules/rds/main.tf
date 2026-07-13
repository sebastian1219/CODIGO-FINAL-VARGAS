terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Subnet Group para Aurora
resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}

# Aurora Cluster
resource "aws_rds_cluster" "this" {
  cluster_identifier      = "${var.environment}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = var.engine_version
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.sg_ids
  skip_final_snapshot     = true

  # Correcciones de seguridad y cumplimiento
  kms_key_id                          = aws_kms_key.rds.arn
  iam_database_authentication_enabled = true
  deletion_protection                 = true
  storage_encrypted                   = true
  copy_tags_to_snapshot               = true

  # 🔽 Activación de logs en CloudWatch
  enabled_cloudwatch_logs_exports = [
    "postgresql",   # consultas de Postgres
    "error",        # errores
    "general",      # logs generales
    "slowquery"     # consultas lentas
  ]

  tags = {
    Name        = "${var.environment}-aurora-cluster"
    Environment = var.environment
  }
}

# Aurora Instance
resource "aws_rds_cluster_instance" "this" {
  identifier         = "${var.environment}-aurora-instance"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.instance_class
  engine             = "aurora-postgresql"

  auto_minor_version_upgrade      = true
  performance_insights_enabled    = true
  performance_insights_kms_key_id = aws_kms_key.rds.arn
  monitoring_interval             = 60

  tags = {
    Name        = "${var.environment}-aurora-instance"
    Environment = var.environment
  }
}

# Clave KMS con política explícita
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS cluster"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "rds-key-policy",
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

# Backup Vault
resource "aws_backup_vault" "rds" {
  name        = "${var.environment}-rds-vault"
  kms_key_arn = aws_kms_key.rds.arn
}

# Backup Plan
resource "aws_backup_plan" "rds" {
  name = "${var.environment}-rds-backup"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.rds.name
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 30
    }
  }
}

# Backup Selection
resource "aws_backup_selection" "rds" {
  name         = "${var.environment}-rds-selection"
  iam_role_arn = var.backup_role_arn
  plan_id      = aws_backup_plan.rds.id

  resources = [aws_rds_cluster.this.arn]
}
