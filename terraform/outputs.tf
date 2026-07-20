output "website_url" {
  description = "URL do site estático"

  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.portfolio.domain_name}"
}