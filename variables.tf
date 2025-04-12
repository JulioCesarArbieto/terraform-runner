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
  description = "AWS region to deploy resources"
  type        = string
  default = "us-east-2"
}

variable "github_webhook_secret_arn" {
  description = "ARN del secreto del webhook de GitHub"
  type        = string
}

variable "codebuild_service_role" {
  description = "IAM Role ARN for CodeBuild projects"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}


variable "github_repo_url" {
  description = "URL of the GitHub repository"
  type        = string
}

variable "eventbridge_role_arn" {
  description = "IAM Role ARN for EventBridge to trigger targets"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "ecs_task_arn" {
  description = "ARN de la definición del task ECS"
  type        = string
}
