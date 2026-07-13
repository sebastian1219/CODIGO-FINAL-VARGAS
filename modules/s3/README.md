**# Módulo S3**



**## 📌 Descripción**

**Este módulo crea un \*\*bucket S3\*\* en AWS para almacenar artefactos de CI/CD, backups o cualquier recurso necesario.**  

**Incluye \*\*versionado\*\* y \*\*cifrado en reposo (AES256)\*\* para cumplir con buenas prácticas de seguridad.**



**---**



**## ⚙️ Recursos**

**- `aws\_s3\_bucket` → Bucket principal.**

**- `aws\_s3\_bucket\_versioning` → Versionado habilitado.**

**- `aws\_s3\_bucket\_server\_side\_encryption\_configuration` → Cifrado en reposo.**



**---**



**## 📑 Variables requeridas**

**- `bucket\_name` → Nombre único del bucket.**

**- `environment` → Nombre del entorno (`dev`, `staging`, `prod`).**



**---**



**## 📤 Outputs**

**- `bucket\_name` → Nombre del bucket creado.**

**- `bucket\_arn` → ARN del bucket.**



**---**



**## 🚀 Ejemplo de uso**

**```hcl**

**module "s3" {**

&#x20; **source      = "./modules/s3"**

&#x20; **bucket\_name = "dev-artifacts-bucket"**

&#x20; **environment = "dev"**

**}**



