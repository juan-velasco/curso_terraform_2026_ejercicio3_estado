variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "eu-west-1"
}

variable "usar_floci" {
  description = "true para trabajar en local con Floci; false para usar AWS"
  type        = bool
  default     = false
}

variable "prefijo" {
  description = "Tu nombre y apellido en minúsculas y con guiones (ej.: ana-lopez)"
  type        = string
}

variable "bucket_estado" {
  description = "Nombre del bucket del estado, creado en 00-bootstrap (output bucket_estado)"
  type        = string
}
