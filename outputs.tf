output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}
