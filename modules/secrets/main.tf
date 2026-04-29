resource "aws_ssm_parameter" "bucket_name" {
  name  = "/${var.project_name}/bucket_name"
  value = var.bucket_name
  type  = "String"
}

resource "aws_ssm_parameter" "cdn_url" {
  name  = "/${var.project_name}/cdn_url"
  value = var.cdn_url
  type  = "String"
}
