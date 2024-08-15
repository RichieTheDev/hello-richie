module "eks" {
  # Source of the EKS module from Terraform Registry
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # EKS Cluster configuration
  cluster_name                             = var.cluster_name                             # Name of the EKS cluster
  cluster_version                          = var.cluster_version                          # Version of the Kubernetes cluster
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access           # Should the cluster endpoint be publicly accessible?
  vpc_id                                   = var.vpc_id                                   # ID of the VPC where the EKS cluster will be deployed
  subnet_ids                               = var.subnet_ids                               # List of subnet IDs for worker nodes
  control_plane_subnet_ids                 = var.control_plane_subnet_ids                 # List of subnet IDs for the EKS control plane
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions # Grant admin permissions to the cluster creator

  # Add-ons configuration for the EKS cluster (e.g., CoreDNS, VPC CNI)
  cluster_addons = var.cluster_addons

  # Default configuration for managed node groups
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types # Instance types for the EKS worker nodes
  }

  # Configuration for the default EKS managed node group
  eks_managed_node_groups = {
    default = {
      ami_type       = var.ami_type       # AMI type for the EKS worker nodes
      instance_types = var.instance_types # Instance types for the EKS worker nodes
      min_size       = var.min_size       # Minimum number of worker nodes
      max_size       = var.max_size       # Maximum number of worker nodes
      desired_size   = var.desired_size   # Desired number of worker nodes
    }
  }

  # Tags to apply to the EKS cluster and associated resources
  tags = var.tags
}
