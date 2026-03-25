output "bucket_name" { value = aws_s3_bucket.s3_bucket.bucket }
output "cdn_url" { value = aws_cloudfront_distribution.cdn.domain_name }
