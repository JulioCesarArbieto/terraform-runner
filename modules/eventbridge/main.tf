resource "aws_eventbridge_rule" "pipeline_rule" {
  name        = "pipeline-rule"
  event_pattern = jsonencode({
    "source" = ["aws.codepipeline"],
    "detail-type" = ["CodePipeline Pipeline Execution State Change"],
    "detail" = {
      "pipeline" = [var.pipeline_arn]
    }
  })
}

resource "aws_eventbridge_target" "pipeline_target" {
  rule = aws_eventbridge_rule.pipeline_rule.name
  arn  = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:your-lambda-function"

  // Otras configuraciones necesarias
}
