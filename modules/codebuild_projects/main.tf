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

resource "aws_codebuild_project" "this" {
  name          = var.name_prefix
  description   = "CodeBuild project for ${var.name_prefix}"
  build_timeout = 10

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = var.s3_bucket_name
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }
  }

  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = var.buildspec_path
  }
}