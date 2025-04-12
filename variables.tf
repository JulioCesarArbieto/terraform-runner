variable "region" {
  default = "us-east-2"
}

variable "notification_email" {
  description = "Email para notificaciones del pipeline"
  type        = string
}

variable "pipeline_role_arn" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}
variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "github_webhook_secret_arn" {
  description = "ARN del secreto del webhook de GitHub"
  type        = string
}

variable "codebuild_service_role" {
  description = "Role ARN para CodeBuild"
  type        = string
}

variable "github_repo_url" {
  description = "URL del repositorio de GitHub"
  type        = string
}