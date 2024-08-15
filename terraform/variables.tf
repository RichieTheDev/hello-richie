variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
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
