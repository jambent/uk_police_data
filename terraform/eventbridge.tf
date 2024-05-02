resource "aws_cloudwatch_event_rule" "data_update_check_lambda_0800_invocation_rule" {
  name                = "data-update-check-lambda-0800-invocation-event-rule"
  description         = "triggers data update check lambda at beginning of every day"
  schedule_expression = "cron(08 00 * * ? *)"
}

resource "aws_cloudwatch_event_target" "data_update_check_lambda_0800_target" {
  arn  = aws_lambda_function.data_update_check.arn
  rule = aws_cloudwatch_event_rule.data_update_check_lambda_0800_invocation_rule.name
}