output "security_project_name" {
  value = aws_codebuild_project.security.name
}

output "deploy_project_name" {
  value = aws_codebuild_project.deploy.name
}