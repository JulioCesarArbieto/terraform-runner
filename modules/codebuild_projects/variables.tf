variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository URL (e.g. https://github.com/usuario/repo)"
  type        = string
  default     = "https://github.com/JulioCesarArbieto/terraform-runner"
}

variable "buildspec_path" {
  description = "Path to the buildspec file (e.g. buildspec.yml)"
  type        = string
  default     = "buildspec.yml"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store build artifacts"
  type        = string
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name where tasks will run"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for ECS task"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID for ECS task"
}

variable "ecs_task_definition_name" {
  description = "Nombre del task definition que ejecutará Terraform"
  type        = string
}
