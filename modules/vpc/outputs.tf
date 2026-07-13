output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "IDs de las subnets públicas creadas"
  value       = aws_subnet.public[*].id
}
