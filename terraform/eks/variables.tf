variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to EKS Cluster endpoint"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the worker nodes"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnets for the control plane"
  type        = list(string)
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Enable admin permissions for cluster creator"
  type        = bool
  default     = true
}

variable "cluster_addons" {
  description = "Cluster addons configuration"
  type        = map(any)
}

variable "instance_types" {
  description = "Instance types for EKS"
  type        = list(string)
}

variable "ami_type" {
  description = "AMI type for EKS managed nodes"
  type        = string
}

variable "min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
}

variable "desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
}

variable "tags" {
  description = "Tags for the EKS resources"
  type        = map(string)
}
