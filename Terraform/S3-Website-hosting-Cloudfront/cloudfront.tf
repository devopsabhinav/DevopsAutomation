locals{
    s3_origin_id = aws_s3_bucket_website_configuration.website_bucket_conf.bucket
}

resource "aws_cloudfront_distribution" "s3_distribution" {
    depends_on = [aws_s3_bucket.website_bucket]

  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for ${aws_s3_bucket.website_bucket.arn} Bucket"
  default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

#   aliases = ["mysite.example.com"]   //Add the alias name of the cloudfront distribution or the website name

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0

  restrictions {          //For adding the restrictions based on the geographical locations
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = aws_s3_bucket_website_configuration.website_bucket_conf.bucket
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_distribution_id" {
    value = aws_cloudfront_distribution.s3_distribution.id
}