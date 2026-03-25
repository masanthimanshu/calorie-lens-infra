resource "aws_s3_bucket" "calorie_lens_bucket" { bucket = "calorie-lens-bucket" }

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "calorie_oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "calorie_lens_distribution" {
  enabled = true

  origin {
    origin_id                = "S3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    domain_name              = aws_s3_bucket.calorie_lens_bucket.bucket_regional_domain_name
  }

  default_cache_behavior {
    target_origin_id       = "S3Origin"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate { cloudfront_default_certificate = true }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.calorie_lens_bucket.id
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = {
      Sid       = "AllowCloudFrontServicePrincipalReadOnly"
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.calorie_lens_bucket.arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.calorie_lens_distribution.arn
        }
      }
    }
  })
}
