variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
  nullable    = false
}

variable "cluster_role_arn" {
  description = "ARN del rol IAM para el plano de control del cluster"
  type        = string
  nullable    = false
}

variable "subnet_ids" {
  description = "Lista de subnets donde se desplegará el cluster"
  type        = list(string)
  nullable    = false
}

variable "environment" {
  description = "Nombre del entorno (dev, staging, prod)"
  type        = string
  nullable    = false
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes para el cluster"
  type        = string
  nullable    = false
}
