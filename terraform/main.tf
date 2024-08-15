# AWS provider configuration
provider "aws" {
  region = var.aws_region # The AWS region where resources will be deployed (e.g., us-west-1)
}

# VPC module configuration
module "vpc" {
  source              = "./vpc"                 # Path to the VPC module
  cidr_block          = var.cidr_block          # CIDR block for the VPC (e.g., 10.0.0.0/16)
  public_subnets_cidr = var.public_subnets_cidr # List of CIDR blocks for the public subnets
  availability_zones  = var.availability_zones  # List of availability zones for the subnets
}

# EKS (Elastic Kubernetes Service) module configuration
module "eks" {
  source                   = "./eks"                   # Path to the EKS module
  vpc_id                   = module.vpc.vpc_id         # VPC ID where the EKS cluster will be deployed
  subnet_ids               = module.vpc.public_subnets # Subnet IDs for the worker nodes
  control_plane_subnet_ids = module.vpc.public_subnets # Subnet IDs for the EKS control plane
  cluster_name             = var.cluster_name          # Name of the EKS cluster
  cluster_version          = var.cluster_version       # Kubernetes version for the EKS cluster
  cluster_addons           = var.cluster_addons        # Add-ons for the EKS cluster (e.g., CoreDNS, VPC CNI)
  instance_types           = var.instance_types        # Instance types for the EKS worker nodes
  ami_type                 = var.ami_type              # AMI type for the EKS worker nodes
  min_size                 = var.min_size              # Minimum number of worker nodes
  max_size                 = var.max_size              # Maximum number of worker nodes
  desired_size             = var.desired_size          # Desired number of worker nodes
  tags                     = var.tags                  # Tags to apply to the EKS resources
}

# Security Group module configuration
module "security_group" {
  source = "./security_group" # Path to the Security Group module
  vpc_id = module.vpc.vpc_id  # VPC ID where the security group will be created
}
