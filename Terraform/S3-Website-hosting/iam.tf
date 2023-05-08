data "aws_iam_policy_document" "s3_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.website_bucket.arn}",
      "${aws_s3_bucket.website_bucket.arn}/*",
    ]
  }
}