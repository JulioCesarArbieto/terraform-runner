module "infra_core" {
  source = "./modules/infra_core"
}

module "codebuild_projects" {
  source = "./modules/codebuild_projects"
}

module "ecr" {
  source = "./modules/ecr"
}

module "s3_backend" {
  source = "./modules/s3_backend"
}

module "sns_notifications" {
  source = "./modules/sns_notifications"
  email  = var.notification_email
}

module "security_tools" {
  source = "./modules/security_tools"
}

module "ecs_task" {
  source       = "./modules/ecs_task"
  ecr_repo_url = module.ecr.repository_url
}

module "codepipeline" {
  source                      = "./modules/codepipeline"
  ecs_task_arn                = module.ecs_task.task_definition_arn
  s3_bucket_name              = module.s3_backend.bucket_name
  sns_topic_arn               = module.sns_notifications.topic_arn
  pipeline_role_arn           = var.pipeline_role_arn
  github_owner                = var.github_owner
  github_repo                 = var.github_repo
  github_branch               = var.github_branch
  github_token                = var.github_token
  security_codebuild_project = module.codebuild_projects.security_project_name
  deploy_codebuild_project   = module.codebuild_projects.deploy_project_name
  github_webhook_secret_arn  = var.github_webhook_secret_arn
}

module "eventbridge" {
  source       = "./modules/eventbridge"
  pipeline_arn = module.codepipeline.pipeline_arn
}