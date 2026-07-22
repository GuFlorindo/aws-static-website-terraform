resource "aws_s3_bucket" "portfolio" {
  bucket = "gustavofd-portfolio-2026"

}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.portfolio.id

  key = "index.html"

  source = "../website/index.html"

  content_type = "text/html"

  etag = filemd5("../website/index.html")
}

resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.portfolio.id

  key = "style.css"

  source = "../website/style.css"

  content_type = "text/css"

  etag = filemd5("../website/style.css")
}

resource "aws_s3_object" "script" {
  bucket = aws_s3_bucket.portfolio.id

  key = "script.js"

  source = "../website/script.js"

  content_type = "application/javascript"

  etag = filemd5("../website/script.js")
}

resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_cloudfront_origin_access_control" "portfolio" {

  name = "portfolio-oac"

  description = "Origin Access Control for S3"

  origin_access_control_origin_type = "s3"

  signing_behavior = "always"

  signing_protocol = "sigv4"
}

resource "aws_s3_bucket_policy" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowCloudFrontRead"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = "s3:GetObject"

        Resource = "${aws_s3_bucket.portfolio.arn}/*"

        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.portfolio.arn
          }
        }
      }
    ]
  })
}