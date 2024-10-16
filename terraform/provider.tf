terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.6.0"
    }
    external = {
      source = "hashicorp/external"
    }
  }

  backend "s3"{
    bucket = "global-triangles-tf"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}