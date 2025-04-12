resource "aws_codebuild_project" "security" {
  name          = "security-project"
  service_role  = aws_iam_role.codebuild_role.arn
  source {
    type      = "GITHUB"
    location  = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = "buildspec-security.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variables       = []
  }
}

resource "aws_codebuild_project" "deploy" {
  name          = "deploy-project"
  service_role  = aws_iam_role.codebuild_role.arn
  source {
    type      = "GITHUB"
    location  = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = "buildspec-deploy.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variables       = []
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "terraform-runner-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}