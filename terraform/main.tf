resource "aws_s3_bucket" "portfolio" {
  bucket = "gustavofd-portfolio-2026"

}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
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

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  depends_on = [
    aws_s3_bucket_public_access_block.portfolio
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"

        Resource = "${aws_s3_bucket.portfolio.arn}/*"
      }
    ]
  })
}