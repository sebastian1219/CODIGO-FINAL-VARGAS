variable "cidr_block" {
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
