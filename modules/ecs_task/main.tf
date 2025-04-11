resource "aws_ecs_task_definition" "terraform_runner" {
  family                   = "terraform-runner"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = var.execution_role_arn
  task_role_arn           = var.task_role_arn
  container_definitions   = jsonencode([
    {
      name      = "terraform-runner"
      image     = var.ecr_repo_url
      essential = true
      command   = ["/bin/bash", "-c", "terraform init && terraform apply -auto-approve"]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/terraform-runner",
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.terraform_runner.arn
}