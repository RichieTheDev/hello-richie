variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets IDs for the worker nodes"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnets IDs for the control plane"
  type        = list(string)
}
