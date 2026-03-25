variable "project_name" {
  type        = string
  description = "Enter Project Name"
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "ARN of the CloudFront to access this bucket"
}
