resource "aws_security_group" "eks_sg" {
  # The ID of the VPC where the security group will be created
  vpc_id = var.vpc_id

  # Ingress rules define the inbound traffic allowed to the resources
  ingress {
    from_port   = 0             # Start of the port range (0 indicates all ports)
    to_port     = 0             # End of the port range (0 indicates all ports)
    protocol    = "-1"          # Protocol (-1 means all protocols)
    cidr_blocks = ["0.0.0.0/0"] # CIDR block for allowing access from any IP address
  }

  # Egress rules define the outbound traffic allowed from the resources
  egress {
    from_port   = 0             # Start of the port range (0 indicates all ports)
    to_port     = 0             # End of the port range (0 indicates all ports)
    protocol    = "-1"          # Protocol (-1 means all protocols)
    cidr_blocks = ["0.0.0.0/0"] # CIDR block for allowing outbound traffic to any IP address
  }
}
