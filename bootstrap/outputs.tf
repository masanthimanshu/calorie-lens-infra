output "state_bucket_name" {
  value       = aws_s3_bucket.tf-state-bucket.id
  description = "S3 bucket that stores Terraform state"
}

output "state_lock_table_name" {
  value       = aws_dynamodb_table.tf-state-lock-table.id
  description = "DynamoDB table used for state locking"
}
