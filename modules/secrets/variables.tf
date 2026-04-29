variable "project_name" {
  type        = string
  description = "Enter Project Name"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "cdn_url" {
  type        = string
  description = "CloudFront distribution URL"
}
