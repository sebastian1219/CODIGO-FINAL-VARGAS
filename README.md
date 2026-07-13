**Root Module - Infraestructura AWS con Terraform**

**📌 Descripción**

**Este proyecto define la infraestructura base en AWS utilizando Terraform como IaC.**

**El root module coordina los módulos de VPC, EKS, RDS y S3, asegurando un despliegue modular, seguro y escalable.**





**!\[directorio](imagenes/directorio.png)**



**infra/**

**├── main.tf              # Invoca módulos y define recursos globales**

**├── variables.tf         # Variables obligatorias sin defaults**

**├── outputs.tf           # Salidas principales de la infraestructura**

**├── terraform.tfvars     # Valores específicos por entorno (ej: dev, prod)**

**└── modules/             # Submódulos reutilizables**



**!\[modulos](imagenes/modulos.png)**



**⚙️ Módulos incluidos**

**VPC: Red principal con subnets públicas.**



**EKS: Cluster Kubernetes administrado en AWS.**



**!\[cluster](imagenes/cluster.png)**



**RDS: Base de datos PostgreSQL gestionada.**



**S3: Bucket para artefactos y almacenamiento CI/CD.**



**📑 Variables requeridas**

**Todas las variables se definen en variables.tf y deben ser proporcionadas en terraform.tfvars o como variables de entorno:**



**aws\_region → Región AWS.**



**vpc\_cidr → CIDR de la VPC.**



**public\_subnets → Lista de subnets públicas.**



**azs → Zonas de disponibilidad.**



**environment → Nombre del entorno (dev, staging, prod).**



**cluster\_name → Nombre del cluster EKS.**



**cluster\_role\_arn → ARN del rol IAM para EKS.**



**db\_name, db\_username, db\_password → Configuración de RDS.**



**sg\_ids, subnet\_group → Seguridad y networking para RDS.**



**bucket\_name → Nombre del bucket S3.**



**!\[grupo-seguridad](imagenes/grupo-seguridad.png)**



**Uso**

**Inicializar Terraform:**



**bash**

**terraform init**

**Validar configuración:**



**bash**

**terraform validate**

**Planificar despliegue:**



**bash**

**terraform plan -var-file="terraform.tfvars"**

**Aplicar cambios:**



**!\[terraform-plan](imagenes/terraform-plan.png)**



**bash**

**terraform apply -var-file="terraform.tfvars"**



**!\[apply](imagenes/apply.png)**





**Seguridad y calidad**



**!\[tflint](imagenes/tflint.png)**



**Variables sensibles (db\_password) se manejan con sensitive = true.**



**Validación con Checkov y TFLint en el pipeline CI/CD.**



**!\[checkov](imagenes/checkov.png)**



**Documentación modular con ejemplos en cada README.md.**



**Versionado semántico de módulos (v1.0.0, v1.1.0).**



**Outputs principales**



**!\[apply-add](imagenes/apply-add.png)**



**vpc\_id → ID de la VPC creada.**



**subnet\_ids → Subnets públicas.**



**eks\_cluster\_name → Nombre del cluster EKS.**



**db\_endpoint → Endpoint de la base de datos RDS.**



**s3\_bucket\_name → Nombre del bucket S3.**





**!\[actions](imagenes/actions.png)**



























