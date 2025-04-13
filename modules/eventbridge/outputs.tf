output "eventbridge_role_arn" {
  value = aws_iam_role.eventbridge_role.arn
}

output "eventbridge_rule_arn" {
  description = "The ARN of the CloudWatch Event Rule"
  value = aws_cloudwatch_event_rule.pipeline_rule.arn
}