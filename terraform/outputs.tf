output "bucket_url" {
  value = aws_s3_bucket.www_bucket.website_endpoint
  description = "The website URL for the S3 bucket"
}