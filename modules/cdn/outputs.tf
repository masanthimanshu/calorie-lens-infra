output "cdn_url" {
  description = "The URL of the CloudFront distribution."
  value       = aws_cloudfront_distribution.distribution.domain_name
}

output "distribution_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = aws_cloudfront_distribution.distribution.arn
}
