resource "aws_cloudwatch_event_rule" "pipeline_rule" {
  name        = "${var.name_prefix}-event-rule"
  description = "Trigger CodeBuild on CodeCommit changes"
  event_pattern = jsonencode({
    "source": ["aws.codecommit"]
  })
}

resource "aws_cloudwatch_event_target" "pipeline_target" {
  rule      = aws_cloudwatch_event_rule.pipeline_rule.name
  arn       = var.codebuild_project_arn
  role_arn  = aws_iam_role.eventbridge_role.arn
}

resource "aws_iam_role" "eventbridge_role" {
  name = "${var.name_prefix}-eventbridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}