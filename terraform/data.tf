data "aws_caller_identity" "current" {}

data "archive_file" "data_update_check_lambda" {
  type        = "zip"
  source_dir = "${path.module}/../src/data_update_check"
  output_path = "${path.module}/../lambda_code_zip_files/data_update_check_function.zip"
}