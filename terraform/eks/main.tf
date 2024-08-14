module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                             = "umob-eks-cluster"
  cluster_version                          = "1.30"
  cluster_endpoint_public_access           = true
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.subnet_ids
  control_plane_subnet_ids                 = var.control_plane_subnet_ids
  enable_cluster_creator_admin_permissions = true



  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
