output "cdn_url" { value = aws_cloudfront_distribution.distribution.domain_name }
output "distribution_arn" { value = aws_cloudfront_distribution.distribution.arn }
