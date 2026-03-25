variable "aws_profile" {
  sensitive   = true
  type        = string
  description = "Enter AWS Profile"
}

variable "aws_region" {
  sensitive   = true
  type        = string
  description = "Enter AWS Region"
}
