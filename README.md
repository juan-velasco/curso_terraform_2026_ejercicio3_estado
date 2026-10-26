# Ejercicio 3.1 · Backend remoto y organización del proyecto

Curso G2601118 · Infraestructura como código con Terraform · Módulo 3

La infraestructura del módulo 2, dividida en tres componentes con su propio estado en S3 y bloqueo.

| Carpeta | Contenido | Estado de Terraform |
| --- | --- | --- |
| `00-bootstrap/` | Paso 1: bucket S3 del estado (versionado, cifrado, sin acceso público) | Local |
| `backend-aws.hcl` / `backend-floci.hcl` | Paso 2: configuración común del backend | — |
| `10-red/` | Paso 3: VPC, subred, Internet Gateway y rutas | `red/terraform.tfstate` |
| `20-seguridad/` | Paso 4: grupo de seguridad y reglas | `seguridad/terraform.tfstate` |
| `30-servidor/` | Paso 5: instancia EC2 con nginx | `servidor/terraform.tfstate` |

Requisito: **Terraform 1.11 o posterior** (`terraform -version`), necesario para `use_lockfile`.

Mientras queden huecos `___`, `terraform validate` dará error: es normal.

## 1. Crear el bucket del estado

```bash
cd 00-bootstrap
cp terraform.tfvars.example terraform.tfvars   # y rellénalo
terraform init
terraform apply                                 # anota el output bucket_estado
```

## 2. Configurar el backend

Pon el nombre del bucket en `backend-aws.hcl` (o `backend-floci.hcl` si usas Floci) y en el `terraform.tfvars` de `20-seguridad` y `30-servidor`.

## 3. Desplegar los componentes, en este orden

```bash
cd ../10-red
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=../backend-aws.hcl     # con Floci: ../backend-floci.hcl
terraform apply

cd ../20-seguridad    # mismos pasos
cd ../30-servidor     # mismos pasos; abre la URL del output
```

## 4. Probar el bloqueo

Lanza `terraform apply` en `30-servidor` y, sin confirmar, ejecuta `terraform plan` en otra terminal en la misma carpeta: debe indicar que el estado está bloqueado.

## 5. Destruir, en orden inverso

```bash
cd 30-servidor && terraform destroy
cd ../20-seguridad && terraform destroy
cd ../10-red && terraform destroy
cd ../00-bootstrap && terraform destroy   # el último: borra el bucket con todos los estados
```

## Reto opcional

Migra el estado local del proyecto del módulo 2 a este bucket, con la clave `modulo2/terraform.tfstate`, usando `terraform init -migrate-state`.

## Con Floci

Pon `usar_floci = true` en cada `terraform.tfvars`, usa `backend-floci.hcl` en el `init` e indica `ami_id` en `30-servidor`. Si Floci da error con el bloqueo, pon `use_lockfile = false` en `backend-floci.hcl`: la prueba del bloqueo solo se podrá hacer con AWS.

## Reglas de oro

- **Destruye siempre** lo que crees, en orden inverso.
- **Nunca subas** credenciales, `terraform.tfvars` ni ficheros `*.tfstate` (ya están en `.gitignore`).
