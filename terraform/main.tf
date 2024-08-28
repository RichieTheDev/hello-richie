provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 7
  special = false
}

locals {
  cluster_name = "richie-eks-${random_string.suffix.result}"
}

module "vpc" {
  source = "./vpc"

  cidr_block           = var.cidr_block
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  azs                  = data.aws_availability_zones.available.names
  cluster_name         = local.cluster_name
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
}


module "eks" {
  source = "./eks"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets
  cluster_name             = local.cluster_name
  cluster_version          = var.cluster_version
  security_group_ids       = [module.security_group.all_worker_mgmt_sg_id]
}


