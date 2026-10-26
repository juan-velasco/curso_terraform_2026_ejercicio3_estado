# Backend remoto: el estado de este componente se guarda en S3.
# Aquí solo va la clave (key): el resto (bucket, región, bloqueo...) llega al hacer
#   terraform init -backend-config=../backend-aws.hcl     (AWS)
#   terraform init -backend-config=../backend-floci.hcl   (Floci)
# porque el bloque backend no admite variables.
terraform {
  backend "s3" {
    key = "seguridad/terraform.tfstate"
  }
}
