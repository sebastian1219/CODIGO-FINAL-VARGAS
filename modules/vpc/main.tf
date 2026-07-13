terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# VPC principal
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# Subnets públicas
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name        = "${var.environment}-public-${count.index}"
    Environment = var.environment
  }
}

# Grupo de seguridad por defecto (bloquea todo tráfico)
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress = []
  egress  = []

  tags = {
    Name        = "${var.environment}-default-sg"
    Environment = var.environment
  }
}

# Flow Logs básicos (usa CloudWatch Logs)
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name              = "/aws/vpc/${var.environment}-flow-logs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.logs.arn
}

resource "aws_flow_log" "this" {
  log_destination      = aws_cloudwatch_log_group.vpc_logs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id
}


