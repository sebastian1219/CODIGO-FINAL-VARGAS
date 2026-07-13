variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
  nullable    = false
}

variable "log_bucket_name" {
  description = "Nombre del bucket destino para almacenar logs de acceso"
  type        = string
}

