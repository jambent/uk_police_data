data "aws_iam_policy_document" "assume_role_document" {
  statement {

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

}


data "aws_iam_policy_document" "s3_document" {
  statement {

    actions = [
      "s3:*Object",
      "s3:ListBucket"
    ]
    resources = [
      "${aws_s3_bucket.code_bucket.arn}/*",
      "${aws_s3_bucket.landing_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_policy" {
  name_prefix = "s3-policy-"
  policy      = data.aws_iam_policy_document.s3_document.json
}


resource "aws_iam_role" "data_update_check_lambda_role" {
  name_prefix        = "role-${var.data_update_check}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_document.json
}

resource "aws_iam_role_policy_attachment" "data_update_check_s3_policy_attachment" {
  role       = aws_iam_role.data_update_check_lambda_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
