variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  default = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for hosting the website"
  type = string
  default = "global-triangles-site"
}
