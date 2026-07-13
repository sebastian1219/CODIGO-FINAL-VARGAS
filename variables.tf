variable "aws_region" {
  description = "Región AWS"
  type        = string
  nullable    = false
}

variable "vpc_cidr" {
  description = "CIDR principal de la VPC"
  type        = string
  nullable    = false
}

variable "public_subnets" {
  description = "Lista de subnets públicas"
  type        = list(string)
  nullable    = false
}

variable "azs" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
  nullable    = false
}

variable "environment" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
  nullable    = false
}

variable "cluster_role_arn" {
  description = "ARN del rol para el cluster EKS"
  type        = string
  nullable    = false
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  nullable    = false
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
  nullable    = false
}

variable "log_bucket_name" {
  description = "Nombre del bucket destino para almacenar logs de acceso"
  type        = string
}


# 🔽 Variables necesarias para el módulo RDS (Aurora)
variable "db_username" {
  description = "Usuario maestro del cluster Aurora"
  type        = string
  nullable    = false
}

variable "db_password" {
  description = "Contraseña del cluster Aurora"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "subnet_ids" {
  description = "Lista de subnets para Aurora"
  type        = list(string)
  nullable    = false
}

variable "subnet_group" {
  description = "Nombre del Subnet Group para Aurora"
  type        = string
  nullable    = false
}

variable "sg_ids" {
  description = "Lista de Security Groups para Aurora"
  type        = list(string)
  nullable    = false
}

variable "engine_version" {
  description = "Versión del motor Aurora PostgreSQL"
  type        = string
  default     = "18.3"
}

variable "instance_class" {
  description = "Clase de instancia Aurora"
  type        = string
  default     = "db.t3.medium"
}
