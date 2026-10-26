# Configuración del backend para Floci (se usa con: terraform init -backend-config=../backend-floci.hcl)
# Cambia el nombre del bucket por el que creaste en 00-bootstrap (output bucket_estado).
bucket       = "nombre-apellido-tfstate-curso"
region       = "eu-west-1"
use_lockfile = true # si Floci da error con el bloqueo, cámbialo a false

# Conexión con Floci
access_key                  = "test"
secret_key                  = "test"
skip_credentials_validation = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
skip_region_validation      = true
skip_s3_checksum            = true
use_path_style              = true

endpoints = {
  s3 = "http://localhost:4566"
}
