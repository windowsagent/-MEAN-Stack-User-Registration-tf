 module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = "global-triangles"
  cluster_version                 = "1.31"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size              = 20
    instance_types         = ["t3.small"]
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 2
      min_size = 1
      max_size = 10

      labels = {
        role = "general"
      }
      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "production"
  }
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
  depends_on = [ module.eks.default ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [ module.eks.default ]
}

provider "kubernetes" {
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.name]
  }
}

provider "helm" {
  kubernetes {
    host = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.name]
    }
  }
}
