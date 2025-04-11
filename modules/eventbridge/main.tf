resource "aws_cloudwatch_event_rule" "trigger" {
  name        = "terraform-trigger"
  description = "Trigger pipeline from GitHub push"
  event_pattern = jsonencode({
    source = ["aws.codecommit"],
    detail-type = ["CodeCommit Repository State Change"]
  })
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.trigger.name
  arn  = var.pipeline_arn
}