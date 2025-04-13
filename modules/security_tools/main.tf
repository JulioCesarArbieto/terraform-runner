resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_service_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_codebuild_project" "security_checks" {
  name          = "security-checks"
  description   = "Run security tools like tflint, checkov, terrascan, etc."
  service_role = aws_iam_role.codebuild_role.arn

  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = var.buildspec_path
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/security-checks"
      stream_name = "logs"
    }
  }

  tags = {
    Project = "TerraformRunner"
  }
}