provider "aws" {
region = "us-east-1"
}

resource "aws_s3_bucket" "bucket_seguro" {
#checkov:skip=CKV_AWS_18:"Bucket de demostración para laboratorio"
#checkov:skip=CKV_AWS_21:"Versioning no requerido en demo"
#checkov:skip=CKV_AWS_144:"Replicación entre regiones no requerida"
#checkov:skip=CKV_AWS_145:"Cifrado KMS no requerido para demo"
#checkov:skip=CKV2_AWS_61:"Lifecycle no requerido"
#checkov:skip=CKV2_AWS_62:"Event notifications no requeridos"
bucket = "mi-bucket-devsecops-demo-12345"
}

# CORRECCIÓN IaC: Bloqueo explícito de acceso público
resource "aws_s3_bucket_public_access_block" "publico" {
bucket                  = aws_s3_bucket.bucket_seguro.id
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

resource "aws_security_group" "sg_seguro" {
#checkov:skip=CKV2_AWS_5:"Security Group de demostración sin adjuntar a EC2"
name        = "sg_ssh_restringido"
description = "Grupo de seguridad con SSH restringido a red privada"

ingress {
description = "Acceso SSH restringido a subnet privada"
from_port   = 22
to_port     = 22
protocol    = "tcp"
# CORRECCIÓN IaC: Acceso SSH restringido a red privada
cidr_blocks = ["10.0.0.0/16"]
}
}
