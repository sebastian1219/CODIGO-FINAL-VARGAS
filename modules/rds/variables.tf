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
  description = "Lista de subnets para el DB Subnet Group"
  type        = list(string)
  nullable    = false
}

variable "subnet_group" {
  description = "Nombre del DB Subnet Group"
  type        = string
  nullable    = false
}

variable "sg_ids" {
  description = "Lista de Security Groups asociados al cluster Aurora"
  type        = list(string)
  nullable    = false
}

variable "environment" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
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

