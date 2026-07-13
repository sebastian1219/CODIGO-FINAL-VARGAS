**# Módulo EKS**



**## 📌 Descripción**

**Este módulo crea un \*\*cluster EKS\*\* en AWS con un grupo de nodos administrado.**  

**Permite desplegar aplicaciones en Kubernetes con alta disponibilidad y escalabilidad.**



**---**



**## ⚙️ Recursos**

**- `aws\_eks\_cluster` → Cluster EKS.**

**- `aws\_eks\_node\_group` → Grupo de nodos administrados.**



**---**



**## 📑 Variables requeridas**

**- `cluster\_name` → Nombre del cluster.**

**- `cluster\_role\_arn` → ARN del rol IAM para el plano de control.**

**- `node\_role\_arn` → ARN del rol IAM para los nodos.**

**- `subnet\_ids` → Lista de subnets donde se desplegará el cluster.**

**- `environment` → Nombre del entorno (`dev`, `staging`, `prod`).**

**- `kubernetes\_version` → Versión de Kubernetes.**

**- `node\_desired\_size`, `node\_min\_size`, `node\_max\_size` → Configuración de escalado.**

**- `node\_instance\_types` → Tipos de instancia para los nodos.**



**---**



**## 📤 Outputs**

**- `cluster\_name` → Nombre del cluster.**

**- `cluster\_endpoint` → Endpoint del cluster.**

**- `cluster\_certificate\_authority` → Certificado CA.**

**- `node\_group\_name` → Nombre del grupo de nodos.**



**---**



**## 🚀 Ejemplo de uso**

**```hcl**

**module "eks" {**

&#x20; **source              = "./modules/eks"**

&#x20; **cluster\_name        = "cluster-codigo"**

&#x20; **cluster\_role\_arn    = "arn:aws:iam::123456789012:role/LabEksClusterRole"**

&#x20; **node\_role\_arn       = "arn:aws:iam::123456789012:role/LabEksNodeRole"**

&#x20; **subnet\_ids          = \["subnet-0c88323fdd2ae78b9", "subnet-0c3bfb467b44a3359"]**

&#x20; **environment         = "dev"**

&#x20; **kubernetes\_version  = "1.36"**

&#x20; **node\_desired\_size   = 2**

&#x20; **node\_min\_size       = 1**

&#x20; **node\_max\_size       = 3**

&#x20; **node\_instance\_types = \["t3.medium"]**

**}**



