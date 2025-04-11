resource "aws_codepipeline" "pipeline" {
  name     = "terraform-runner-pipeline"
  role_arn = var.pipeline_role_arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "SecurityChecks"
    action {
      name             = "RunSecurityTools"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["security_output"]
      version          = "1"
      configuration = {
        ProjectName = var.security_codebuild_project
      }
    }
  }

  stage {
    name = "Approval"
    action {
      name     = "ManualApproval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "RunTerraform"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["security_output"]
      version         = "1"
      configuration = {
        ProjectName = var.deploy_codebuild_project
      }
    }
  }

  notification_rule {
    detail_type    = "FULL"
    name           = "pipeline-failure-notification"
    event_type_ids = [
      "codepipeline-pipeline-execution-failed",
      "codepipeline-pipeline-execution-succeeded"
    ]
    resource       = aws_codepipeline.pipeline.arn
    target {
      address = var.sns_topic_arn
      type    = "SNS"
    }
  }
}

variable "sns_topic_arn" {
  type = string
}

variable "security_codebuild_project" {
  type = string
}

variable "deploy_codebuild_project" {
  type = string
}