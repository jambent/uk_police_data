resource "aws_s3_bucket" "code_bucket" {
  bucket_prefix = "code-bucket-"
  force_destroy = true
}

resource "aws_s3_bucket" "landing_bucket" {
  bucket_prefix = "landing-bucket-"
  force_destroy = true
}


/* Loads initial state of last update date as null */
resource "aws_s3_object" "last_updated_date" {
  key    = "last_updated_date.json"
  source = "${path.module}/../initialise_data_collection/initialised_last_updated_date.json"
  bucket = aws_s3_bucket.landing_bucket.id
}

/* Data update check lambda code */
resource "aws_s3_object" "data_update_check_code" {
  key    = "data_update_check_function.zip"
  source = "${path.module}/../lambda_code_zip_files/data_update_check_function.zip"
  bucket = aws_s3_bucket.code_bucket.id
}