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
  layers = [
            aws_lambda_layer_version.requests_layer.arn
        ]
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




##############################################################################
# Force names update check lambda                                                    
##############################################################################

resource "aws_lambda_function" "force_names_update_check" {
  function_name = var.force_names_update_check
  role          = aws_iam_role.force_names_update_check_lambda_role.arn
  s3_bucket     = aws_s3_bucket.code_bucket.id
  s3_key        = aws_s3_object.force_names_update_check_code.key
  handler       = "load_force_names.lambda_handler"
  runtime       = "python3.11"
  timeout       = 60
  environment {
    variables = {
      "S3_LANDING_ID"          = aws_s3_bucket.landing_bucket.id,
      "S3_LANDING_ARN"         = aws_s3_bucket.landing_bucket.arn
    }
  }
  layers = [
            aws_lambda_layer_version.requests_layer.arn
        ]
}

##############################################################################
# 0755 force names update check lambda invocation                                                                 
##############################################################################

resource "aws_lambda_permission" "allow_0755_events" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.force_names_update_check.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.force_names_update_check_lambda_0755_invocation_rule.arn
  source_account = data.aws_caller_identity.current.account_id
}


##############################################################################
# requests lambda layer                                                                
##############################################################################
resource "aws_lambda_layer_version" "requests_layer" {
  filename   = "${path.module}/../lambda_layers/requests_layer.zip"
  layer_name = "requests_layer"

  compatible_runtimes = ["python3.11"]
}