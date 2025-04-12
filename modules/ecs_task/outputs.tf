output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.terraform_runner.arn
  description = "ARN de la definición de tarea ECS para ejecutar Terraform"
}
