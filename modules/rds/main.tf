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
  vpc_security_group_ids  = var.sg_ids   # SG de la misma VPC que subnet_ids
  skip_final_snapshot     = true
  enabled_cloudwatch_logs_exports = ["postgresql", "error", "general", "slowquery"]
  kms_key_id                      = aws_kms_key.rds.arn
}


  # Correcciones mínimas
  iam_database_authentication_enabled = true
  deletion_protection                 = true
  storage_encrypted                   = true
  copy_tags_to_snapshot               = true

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

  # Correcciones mínimas
  auto_minor_version_upgrade = true
  performance_insights_enabled = true
  performance_insights_kms_key_id  = aws_kms_key.rds.arn
  monitoring_interval              = 60

  tags = {
    Name        = "${var.environment}-aurora-instance"
    Environment = var.environment
  }
}
