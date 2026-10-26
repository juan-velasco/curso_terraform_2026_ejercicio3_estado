# Configuración del backend para AWS (se usa con: terraform init -backend-config=../backend-aws.hcl)
# Cambia el nombre del bucket por el que creaste en 00-bootstrap (output bucket_estado).
bucket       = "nombre-apellido-tfstate-curso"
region       = "eu-west-1"
encrypt      = true # cifra el fichero de estado en S3
use_lockfile = true # bloqueo del estado con un fichero .tflock en el propio bucket
