resource "aws_codebuild_project" "security_checks" {
  name         = "terraform-security-checks"
  service_role = var.codebuild_service_role
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }
  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = "buildspec-security.yml"
  }
}

output "security_project_name" {
  value = aws_codebuild_project.security_checks.name
}