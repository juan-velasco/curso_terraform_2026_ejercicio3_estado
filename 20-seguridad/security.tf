# PASO 4 · Grupo de seguridad del servidor web (el del módulo 2)
# La VPC ya no está en este proyecto: su id llega de la red por terraform_remote_state.

resource "aws_security_group" "web" {
  name        = "${var.prefijo}-sg-web"
  description = "Servidor web: HTTP de entrada y toda la salida"
  vpc_id      = ___ # data.terraform_remote_state.<nombre>.outputs.<output>

  tags = {
    Name = "${var.prefijo}-sg-web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  description       = "HTTP"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "todo" {
  security_group_id = aws_security_group.web.id
  description       = "Toda la salida"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
