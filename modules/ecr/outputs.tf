output "repository_url" {
  description = "URL del repositorio ECR"
  value       = aws_ecr_repository.terraform_runner.repository_url
}

output "repository_name" {
  description = "Nombre del repositorio ECR"
  value       = aws_ecr_repository.terraform_runner.name
}