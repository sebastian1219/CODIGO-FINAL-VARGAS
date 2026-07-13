**# Módulo VPC**



**## 📌 Descripción**

**Este módulo crea una \*\*VPC\*\* en AWS con soporte DNS y subnets públicas.**  

**Es un componente base para desplegar servicios como \*\*EKS\*\* y \*\*RDS\*\*.**



**---**



**## ⚙️ Recursos**

**- `aws\_vpc` → Red principal.**

**- `aws\_subnet` → Subnets públicas asociadas a la VPC.**



**---**



**## 📑 Variables requeridas**

**- `cidr\_block` → CIDR principal de la VPC.**

**- `public\_subnets` → Lista de subnets públicas.**

**- `azs` → Lista de zonas de disponibilidad.**

**- `environment` → Nombre del entorno (`dev`, `staging`, `prod`).**



**---**



**## 📤 Outputs**

**- `vpc\_id` → ID de la VPC creada.**

**- `subnet\_ids` → Lista de IDs de las subnets públicas.**



**---**



**## 🚀 Ejemplo de uso**

**```hcl**

**module "vpc" {**

&#x20; **source        = "./modules/vpc"**

&#x20; **cidr\_block    = "10.0.0.0/16"**

&#x20; **public\_subnets = \["10.0.1.0/24", "10.0.2.0/24"]**

&#x20; **azs           = \["us-east-1a", "us-east-1b"]**

&#x20; **environment   = "dev"**

**}**



