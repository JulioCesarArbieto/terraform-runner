variable "github_owner" {
  description = "Propietario del repositorio GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nombre del repositorio GitHub"
  type        = string
}

variable "github_branch" {
  description = "Rama del repositorio GitHub"
  type        = string
  default     = "main"
}

variable "security_codebuild_name" {
  description = "Nombre del proyecto CodeBuild para análisis de seguridad"
  type        = string
}

variable "deploy_codebuild_name" {
  description = "Nombre del proyecto CodeBuild para despliegue"
  type        = string
}

variable "ecs_task_definition_arn" {
  description = "ARN de la definición de tarea ECS"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}
