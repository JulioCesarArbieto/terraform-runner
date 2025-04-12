resource "aws_codebuild_project" "security" {
  name           = "security-check"
  description    = "Security checks for the pipeline"
  service_role   = var.codebuild_service_role
  artifacts {
    type     = "S3"
    location = var.s3_bucket_name
  }

  source {
    type = "GITHUB"
    location = var.github_repo_url
  }
}

resource "aws_codebuild_project" "deploy" {
  name           = "deploy-check"
  description    = "Deploy checks for the pipeline"
  service_role   = var.codebuild_service_role
  artifacts {
    type     = "S3"
    location = var.s3_bucket_name
  }

  source {
    type = "GITHUB"
    location = var.github_repo_url
  }
}
