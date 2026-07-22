output "cloudfront_url" {
  description = "URL da distribuição CloudFront"

  value = "https://${aws_cloudfront_distribution.portfolio.domain_name}"
}

output "bucket_name" {
  description = "Nome do bucket S3"

  value = aws_s3_bucket.portfolio.bucket
}