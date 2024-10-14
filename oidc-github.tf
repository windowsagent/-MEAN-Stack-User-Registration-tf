module "oidc-github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.8.0"

  github_repositories = [
    "windowsagent/MEAN-Stack-User-Registration-Front-End"
  ]
}