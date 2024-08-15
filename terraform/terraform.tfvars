aws_region             = "us-west-1"
cidr_block             = "10.0.0.0/16"
public_subnets_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones     = ["us-west-1a", "us-west-1b"]
cluster_name           = "umob-eks-cluster"
cluster_version        = "1.30"
cluster_addons         = {
  coredns                = {}
  eks-pod-identity-agent = {}
  kube-proxy             = {}
  vpc-cni                = {}
}
instance_types         = ["t3.medium"]
ami_type               = "AL2023_x86_64_STANDARD"
min_size               = 1
max_size               = 3
desired_size           = 1
tags                   = {
  Environment = "dev"
  Terraform   = "true"
}
