variable "name_prefix" {
  description = "The prefix for the resource names"
  type        = string
}

variable "codebuild_project_arn" {
  description = "The ARN of the CodeBuild project"
  type        = string
}