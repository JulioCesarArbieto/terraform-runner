variable "github_repo_url" {
  description = "GitHub repository URL for CodeBuild project"
  type        = string
}

variable "buildspec_path" {
  description = "Path to the buildspec file"
  type        = string
  default     = "buildspec.yml"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for CodeBuild artifact storage"
  type        = string
}

variable "codebuild_service_role" {
  description = "IAM Role ARN for CodeBuild"
  type        = string
}
