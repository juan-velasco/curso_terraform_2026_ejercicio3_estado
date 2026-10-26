# Imagen de Ubuntu 24.04 publicada por Canonical (solo se busca si no indicas ami_id)
data "aws_ami" "ubuntu" {
  count       = var.ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

locals {
  ami = coalesce(var.ami_id, one(data.aws_ami.ubuntu[*].id))
}

# PASO 5 · El servidor web del módulo 2
# La subred y el grupo de seguridad llegan de otros estados por terraform_remote_state.
#
# En el módulo 2 había un depends_on al Internet Gateway y a la tabla de rutas.
# Aquí ya no hace falta (ni se puede: esos recursos están en otro estado): la red se
# aplica antes que el servidor, así que la salida a Internet ya existe cuando arranca.
resource "aws_instance" "web" {
  ami                         = local.ami
  instance_type               = var.tipo_instancia
  subnet_id                   = ___ # output subred_publica_id de la red
  vpc_security_group_ids      = [___] # output sg_web_id de la seguridad
  user_data_replace_on_change = true

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    echo "<h1>Hola desde ${var.prefijo}</h1><p>Servidor creado con Terraform y estado en S3</p>" > /var/www/html/index.html
    systemctl enable --now nginx
  EOT

  tags = {
    Name = "${var.prefijo}-web"
  }
}
