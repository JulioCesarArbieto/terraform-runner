resource "aws_codepipeline" "this" {
  name     = "terraform-pipeline"
  role_arn = var.pipeline_role_arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "Source"
      category = "Source"
      owner    = "ThirdParty"
      provider = "GitHub"
      version  = "1"  # Debes agregar esta línea
      output_artifacts = ["source_output"]
      configuration = {
        "Owner"     = var.github_owner
        "Repo"      = var.github_repo
        "Branch"    = var.github_branch
        "OAuthToken"= var.github_token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name     = "CodeBuild"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
    }
  }
}