variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}
