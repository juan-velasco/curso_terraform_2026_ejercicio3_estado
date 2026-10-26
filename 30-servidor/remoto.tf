# PASO 5 · Leer los outputs de la red y de la seguridad desde S3
# El de la red ya está resuelto: úsalo como modelo para el de la seguridad

data "terraform_remote_state" "red" {
  backend = "s3"

  config = {
    bucket = var.bucket_estado
    key    = "10-red/terraform.tfstate"
    region = var.region

    # Solo con Floci (con AWS valen null o false y no se usan)
    access_key                  = var.usar_floci ? "test" : null
    secret_key                  = var.usar_floci ? "test" : null
    skip_credentials_validation = var.usar_floci
    skip_requesting_account_id  = var.usar_floci
    skip_metadata_api_check     = var.usar_floci
    skip_region_validation      = var.usar_floci
    skip_s3_checksum            = var.usar_floci
    use_path_style              = var.usar_floci
    endpoints                   = var.usar_floci ? { s3 = local.floci } : null
  }
}

# Completa el nombre y la clave (key): la misma que usa 20-seguridad en su backend.tf
data "terraform_remote_state" "___" {
  backend = "s3"

  config = {
    bucket = var.bucket_estado
    key    = ___
    region = var.region

    # Solo con Floci (con AWS valen null o false y no se usan)
    access_key                  = var.usar_floci ? "test" : null
    secret_key                  = var.usar_floci ? "test" : null
    skip_credentials_validation = var.usar_floci
    skip_requesting_account_id  = var.usar_floci
    skip_metadata_api_check     = var.usar_floci
    skip_region_validation      = var.usar_floci
    skip_s3_checksum            = var.usar_floci
    use_path_style              = var.usar_floci
    endpoints                   = var.usar_floci ? { s3 = local.floci } : null
  }
}
