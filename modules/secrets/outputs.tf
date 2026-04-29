output "bucket_name_parameter" {
  value = aws_ssm_parameter.bucket_name.name
}

output "cdn_url_parameter" {
  value = aws_ssm_parameter.cdn_url.name
}
