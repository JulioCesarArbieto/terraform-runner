output "codebuild_project_name" {
  value = aws_codebuild_project.this.name
}

output "codebuild_project_arn" {
  value = aws_codebuild_project.this.arn
}
