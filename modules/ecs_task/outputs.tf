output "task_definition_arn" {
  description = "ARN de la definición del task ECS"
  value       = aws_ecs_task_definition.terraform_runner.arn
}