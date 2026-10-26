# PASO 3 · Los outputs son el CONTRATO con los demás componentes:
# 20-seguridad y 30-servidor los leen con terraform_remote_state.

output "vpc_id" {
  description = "Identificador de la VPC"
  value       = aws_vpc.principal.id
}

output "subred_publica_id" {
  description = "Identificador de la subred pública"
  value       = ___
}

output "internet_gateway_id" {
  description = "Identificador del Internet Gateway"
  value       = ___
}
