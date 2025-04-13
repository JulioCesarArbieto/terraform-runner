variable "ecs_task_arn" {
  description = "ARN de la definición de tarea ECS"
  type        = string
  default     = ""
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para el estado de Terraform"
  type        = string
  default     = ""
}

variable "pipeline_role_arn" {
  description = "ARN del rol para CodePipeline"
  type        = string
  default     = ""
}

variable "github_owner" {
  description = "Propietario del repositorio en GitHub"
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "Nombre del repositorio en GitHub"
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Nombre de la rama de GitHub"
  type        = string
  default     = ""
}

variable "github_token" {
  description = "Token de autenticación de GitHub"
  type        = string
  default     = ""
}

variable "github_webhook_secret_arn" {
  description = "ARN del secreto del webhook de GitHub"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "name_prefix nombre aplicacion"
  type        = string
  default     = ""
}

variable "codebuild_project_name" {
  description = "Nombre del proyecto de CodeBuild que usará CodePipeline"
  type        = string
}
