module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  
  name = "eks-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = {
    Environment = "production"
  }
}