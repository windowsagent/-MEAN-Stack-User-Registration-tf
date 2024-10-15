module "oidc-github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.8.0"

  github_repositories = [
    "windowsagent/MEAN-Stack-User-Registration-Front-End",
    "windowsagent/MEAN-Stack-User-Registration---Back-End"
  ]

  iam_role_inline_policies = {
    "ecr-container-policy": data.aws_iam_policy_document.ecr_container_policy.json
  }
}


data "aws_iam_policy_document" "ecr_container_policy" {
  statement {
    actions   = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}