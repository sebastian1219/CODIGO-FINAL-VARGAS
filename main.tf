terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
module "vpc" {
  source         = "./modules/vpc"
  cidr_block     = var.vpc_cidr
  public_subnets = var.public_subnets
  azs            = var.azs
  environment    = var.environment
}

# EKS
module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  cluster_role_arn   = var.cluster_role_arn
  subnet_ids         = module.vpc.subnet_ids
  environment        = var.environment
  kubernetes_version = var.kubernetes_version
}


# RDS (Aurora)
module "rds" {
  source         = "./modules/rds"
  environment    = var.environment
  db_username    = var.db_username
  db_password    = var.db_password
  subnet_ids     = var.subnet_ids
  subnet_group   = var.subnet_group
  sg_ids         = var.sg_ids  
  engine_version = var.engine_version
  instance_class = var.instance_class
}


 

# S3
module "s3" {
  source          = "./modules/s3"
  bucket_name     = var.bucket_name
  environment     = var.environment
  log_bucket_name = var.log_bucket_name
  replication_bucket = "mi-bucket-replica"
}

