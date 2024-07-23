resource "aws_cloudwatch_event_rule" "data_update_check_lambda_0800_invocation_rule" {
  name                = "data-update-check-lambda-0800-invocation-event-rule"
  description         = "triggers data update check lambda at beginning of every day"
  schedule_expression = "cron(0 8 * * ? *)"
}

resource "aws_cloudwatch_event_target" "data_update_check_lambda_0800_target" {
  arn  = aws_lambda_function.data_update_check.arn
  rule = aws_cloudwatch_event_rule.data_update_check_lambda_0800_invocation_rule.name
}



resource "aws_cloudwatch_event_rule" "force_names_update_check_lambda_0755_invocation_rule" {
  name                = "force-names-update-check-lambda-0755-invocation-event-rule"
  description         = "triggers force names update check lambda at beginning of every day"
  schedule_expression = "cron(55 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "force_names_update_check_lambda_0755_target" {
  arn  = aws_lambda_function.force_names_update_check.arn
  rule = aws_cloudwatch_event_rule.force_names_update_check_lambda_0755_invocation_rule.name
}