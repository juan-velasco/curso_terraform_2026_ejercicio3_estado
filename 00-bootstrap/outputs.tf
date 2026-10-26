output "bucket_estado" {
  description = "Bucket del estado: ponlo en backend-aws.hcl (o backend-floci.hcl) y en el terraform.tfvars de cada componente"
  value       = aws_s3_bucket.estado.bucket
}
