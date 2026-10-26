# PASO 1 · El bucket donde se guardará el estado de los demás componentes.
# Este proyecto usa estado LOCAL: el bucket tiene que existir antes que el backend.

# Bucket (ya resuelto)
resource "aws_s3_bucket" "estado" {
  bucket        = "${var.prefijo}-tfstate-curso"
  force_destroy = true # permite borrarlo con destroy aunque tenga versiones guardadas

  tags = {
    Name = "${var.prefijo}-tfstate-curso"
    Uso  = "estado-terraform"
  }
}

# Versionado (ya resuelto): cada cambio del estado guarda una versión nueva
resource "aws_s3_bucket_versioning" "estado" {
  bucket = aws_s3_bucket.estado.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Cifrado en reposo (complétalo). Documentación:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "estado" {
  bucket = ___

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = ___ # "AES256": claves gestionadas por S3
    }
  }
}

# Bloqueo de todo acceso público (complétalo): el estado puede contener secretos.
# Los cuatro argumentos deben valer true. Documentación:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "estado" {
  bucket = ___

  block_public_acls       = ___
  block_public_policy     = ___
  ignore_public_acls      = ___
  restrict_public_buckets = ___
}
