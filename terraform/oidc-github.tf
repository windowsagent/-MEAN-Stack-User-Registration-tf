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
      "ecr:*",
      "ecr-public:*",
      "cloudtrail:LookupEvents",
      "iam:CreateServiceLinkedRole"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}