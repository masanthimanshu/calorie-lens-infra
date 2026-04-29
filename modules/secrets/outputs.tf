output "bucket_name_parameter" {
  value       = aws_ssm_parameter.bucket_name.name
  description = "SSM parameter name for the secrets bucket name"
}

output "cdn_url_parameter" {
  value       = aws_ssm_parameter.cdn_url.name
  description = "SSM parameter name for the CDN URL"
}
