resource "aws_iam_role_policy" "codebuild_ecs_run_task" {
  name = "${var.name_prefix}-codebuild-run-task"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:RunTask",
          "ecs:DescribeTasks",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}