provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./vpc"
  cidr_block          = "10.0.0.0/16"                  # Pass the CIDR block
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"] # Pass the public subnets CIDR blocks
  availability_zones  = ["us-west-1a", "us-west-1b"]
}

module "eks" {
  source = "./eks"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets
}
