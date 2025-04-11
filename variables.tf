variable "region" {
  default = "us-east-1"
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
