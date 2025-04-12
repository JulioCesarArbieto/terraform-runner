resource "aws_cloudwatch_event_rule" "pipeline_rule" {
  name        = "my-event-rule"
  description = "Trigger CodePipeline"
  event_pattern = jsonencode({
    "source": ["aws.codecommit"]
  })
}

resource "aws_cloudwatch_event_target" "pipeline_target" {
  rule      = aws_cloudwatch_event_rule.pipeline_rule.name
  arn       = var.pipeline_arn
  role_arn  = var.eventbridge_role_arn
}
