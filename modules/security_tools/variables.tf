variable "github_repo_url" {
  description = "URL del repositorio de GitHub"
  type        = string
}

variable "codebuild_service_role" {
  description = "Rol IAM para el servicio de CodeBuild"
  type        = string
}
