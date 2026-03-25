variable "aws_access_key" {
  sensitive   = true
  type        = string
  description = "Enter AWS Access Key"
}

variable "aws_secret_key" {
  sensitive   = true
  type        = string
  description = "Enter AWS Secret Key"
}

variable "aws_region" {
  sensitive   = true
  type        = string
  description = "Enter AWS Region"
}
