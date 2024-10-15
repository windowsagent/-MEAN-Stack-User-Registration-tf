resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  force_destroy = true

  tags = {
    Name = "Angular Static Website"
  }
}

resource "aws_s3_bucket_website_configuration" "www_bucket_conf" {
    bucket = aws_s3_bucket.www_bucket.id
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "error.html"
    }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.www_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.www_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.www_bucket.arn}/*"
      }
    ]
  })
}