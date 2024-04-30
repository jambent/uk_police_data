resource "aws_s3_bucket" "landing_bucket" {
  bucket_prefix = "landing-bucket-"
  force_destroy = true
}


resource "aws_s3_object" "last_updated_date" {
  key    = "last_updated_date.json"
  source = "${path.module}/../initialise_data_collection/initialised_last_updated_date.json"
  bucket = aws_s3_bucket.landing_bucket.id
}