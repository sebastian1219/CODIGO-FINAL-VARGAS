# Endpoint del cluster Aurora
output "db_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

# Nombre del cluster Aurora
output "db_name" {
  value = aws_rds_cluster.this.cluster_identifier
}

# ARN del cluster Aurora
output "db_arn" {
  value = aws_rds_cluster.this.arn
}

# Identificador de la instancia Aurora
output "db_instance_id" {
  value = aws_rds_cluster_instance.this.id
}
