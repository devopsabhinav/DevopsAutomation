variable "aws_profile"{
    type = string
}

provider "aws" {
  profile = "${var.aws_profile}"
  region = "ap-south-1"
} 

variable "s3_bucket_name" {
    type = string
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.s3_bucket_name}"
}

resource "aws_s3_bucket_website_configuration" "website_bucket_conf" {
  depends_on = [aws_s3_bucket.website_bucket]

  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
  depends_on = [aws_s3_bucket.website_bucket]

  bucket = aws_s3_bucket_website_configuration.website_bucket_conf.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  depends_on = [aws_s3_bucket.website_bucket]

  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

output "s3_bucket_url"{
  value = aws_s3_bucket_website_configuration.website_bucket_conf.bucket
}