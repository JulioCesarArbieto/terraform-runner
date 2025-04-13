variable "codebuild_service_role" {
  description = "The name of the CodeBuild service role"
  type        = string
}

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
