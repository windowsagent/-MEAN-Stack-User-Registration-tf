module "oidc-github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.8.0"

  github_repositories = [
    "windowsagent/MEAN-Stack-User-Registration-Front-End",
    "windowsagent/MEAN-Stack-User-Registration---Back-End"
  ]

  iam_role_inline_policies = {
    "s3-bucket-site-policy": data.aws_iam_policy_document.s3_bucket_site_policy.json
  }
}


data "aws_iam_policy_document" "s3_bucket_site_policy" {
  statement {
    actions   = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.www_bucket.arn}/*"]
  }
}