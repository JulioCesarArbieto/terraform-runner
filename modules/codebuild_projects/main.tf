# Obtención de la identidad de la cuenta AWS
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "codebuild_role" {
  name = "${var.name_prefix}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role_policy" "codebuild_cloudwatch_policy" {
  name = "CodeBuildCloudWatchPolicy"
  role = aws_iam_role.codebuild_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_s3_access" {
  name = "${var.name_prefix}-codebuild-s3-access"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_ecs_access" {
  name = "${var.name_prefix}-codebuild-ecs-access"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:RunTask",
          "ecs:DescribeTasks",
          "ecs:DescribeTaskDefinition",
          "ecs:ListTasks"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.name_prefix}-artifacts-bucket"
  force_destroy = true

  tags = {
    Name = "${var.name_prefix}-artifacts"
  }
}

resource "aws_codebuild_project" "this" {
  name          = "${var.name_prefix}-codebuild-project"
  description   = "CodeBuild project for ${var.name_prefix}"
  build_timeout = 10

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
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

    environment_variable {
      name  = "TASK_DEFINITION"
      value = var.ecs_task_definition_name
    }

    environment_variable {
      name  = "ECS_CLUSTER"
      value = var.ecs_cluster_name
    }

    environment_variable {
      name  = "SUBNET_ID"
      value = var.subnet_id
    }

    environment_variable {
      name  = "SECURITY_GROUP_ID"
      value = var.security_group_id
    }

    environment_variable {
      name  = "CLUSTER_NAME"
      value = var.ecs_cluster_name
    }
  }

  source {
    type      = "GITHUB"
    location  = var.github_repo_url
    buildspec = var.buildspec_path
  }

  depends_on = [
    aws_iam_role_policy_attachment.codebuild_policy,
    aws_iam_role_policy.codebuild_s3_access,
    aws_iam_role_policy.codebuild_cloudwatch_policy,
    aws_iam_role_policy.codebuild_ecs_access,
    aws_s3_bucket.artifact_bucket
  ]
}
