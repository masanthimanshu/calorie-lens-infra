resource "aws_s3_bucket" "tf-state-bucket" { bucket = "${var.project_name}-tf-state-bucket" }

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.tf-state-bucket.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.tf-state-bucket.id

  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

resource "aws_dynamodb_table" "tf-state-lock-table" {
  name         = "${var.project_name}-tf-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
