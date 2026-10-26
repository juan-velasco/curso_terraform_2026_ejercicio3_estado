output "ip_publica" {
  description = "IP pública del servidor web"
  value       = aws_instance.web.public_ip
}

output "url" {
  description = "Dirección del servidor web (espera 1-2 minutos tras el apply)"
  value       = "http://${aws_instance.web.public_ip}"
}
