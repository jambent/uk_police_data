##############################################################################
# Data update check lambda                                                    
##############################################################################

resource "aws_lambda_function" "data_update_check" {
  function_name = var.data_update_check
  role          = aws_iam_role.data_update_check_lambda_role.arn
  s3_bucket     = aws_s3_bucket.code_bucket.id
  s3_key        = aws_s3_object.data_update_check_code.key
  handler       = "data_update_check.lambda_handler"
  runtime       = "python3.11"
  timeout       = 60
  environment {
    variables = {
      "S3_LANDING_ID"          = aws_s3_bucket.landing_bucket.id,
      "S3_LANDING_ARN"         = aws_s3_bucket.landing_bucket.arn
    }
  }

}

##############################################################################
# 0800 data update check lambda invocation                                                                 
##############################################################################

resource "aws_lambda_permission" "allow_0800_events" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.data_update_check.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.data_update_check_lambda_0800_invocation_rule.arn
  source_account = data.aws_caller_identity.current.account_id
}