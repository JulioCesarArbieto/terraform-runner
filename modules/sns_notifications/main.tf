resource "aws_sns_topic" "pipeline_alerts" {
  name = "terraform-runner-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.pipeline_alerts.arn
  protocol  = "email"
  endpoint  = var.email
}