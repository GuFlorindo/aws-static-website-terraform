resource "aws_cloudfront_distribution" "portfolio" {

  enabled = true

  origin {

    domain_name = aws_s3_bucket.portfolio.bucket_regional_domain_name

    origin_id = "portfolio-s3"

    origin_access_control_id = aws_cloudfront_origin_access_control.portfolio.id

    s3_origin_config {
      origin_access_identity = ""
    }

  }

  default_cache_behavior {

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    target_origin_id = "portfolio-s3"

    viewer_protocol_policy = "redirect-to-https"

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_root_object = "index.html"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}