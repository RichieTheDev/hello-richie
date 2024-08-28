module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.13.0"
  name                 = var.cluster_name
  cidr                 = var.cidr_block
  azs                  = var.azs
  private_subnets      = var.private_subnets_cidr
  public_subnets       = var.public_subnets_cidr
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
