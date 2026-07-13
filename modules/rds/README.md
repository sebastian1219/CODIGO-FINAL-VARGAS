**# Módulo RDS**



**## 📌 Descripción**

**Este módulo crea una instancia \*\*RDS PostgreSQL\*\* en AWS, con un \*\*DB Subnet Group\*\* y \*\*Security Groups\*\* definidos externamente.**  

**Es el componente de base de datos de la infraestructura, pensado para integrarse con aplicaciones desplegadas en EKS.**



**---**



**## ⚙️ Recursos**

**- `aws\_db\_subnet\_group` → Agrupa subnets para la base de datos.**

**- `aws\_db\_instance` → Instancia PostgreSQL gestionada.**



**---**



**## 📑 Variables requeridas**

**- `db\_name` → Nombre de la base de datos.**

**- `db\_username` → Usuario administrador.**

**- `db\_password` → Contraseña (sensible).**

**- `subnet\_ids` → Subnets donde se desplegará la base de datos.**

**- `subnet\_group` → Nombre del DB Subnet Group.**

**- `sg\_ids` → Security Groups asociados.**

**- `environment` → Nombre del entorno (`dev`, `staging`, `prod`).**



**### Variables opcionales**

**- `engine\_version` → Versión de PostgreSQL (default: `15.4`).**

**- `instance\_class` → Clase de instancia (default: `db.t3.micro`).**

**- `allocated\_storage` → Almacenamiento en GB (default: `20`).**



**---**



**## 📤 Outputs**

**- `db\_endpoint` → Endpoint de conexión.**

**- `db\_name` → Nombre de la base de datos.**



**---**



**## 🚀 Ejemplo de uso**

**```hcl**

**module "rds" {**

&#x20; **source        = "./modules/rds"**

&#x20; **db\_name       = "appdb"**

&#x20; **db\_username   = "adminuser"**

&#x20; **db\_password   = "SuperSecret123!"**

&#x20; **subnet\_ids    = \["subnet-0c88323fdd2ae78b9", "subnet-0c3bfb467b44a3359"]**

&#x20; **subnet\_group  = "dev-db-subnet-group"**

&#x20; **sg\_ids        = \["sg-0123456789abcdef0"]**

&#x20; **environment   = "dev"**

**}**



