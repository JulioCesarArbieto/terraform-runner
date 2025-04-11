output "bucket_name" {
  description = "Nombre del bucket S3 para backend"
  value       = aws_s3_bucket.tf_backend.id
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para bloqueo de estado"
  value       = aws_dynamodb_table.tf_locks.name
}