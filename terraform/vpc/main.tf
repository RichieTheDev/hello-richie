# Create a VPC (Virtual Private Cloud) to define the network space for your AWS resources
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block # The IP address range for the VPC (e.g., 10.0.0.0/16)
  enable_dns_support   = true           # Enable DNS support in the VPC, allowing DNS resolution within the VPC
  enable_dns_hostnames = true           # Enable DNS hostnames in the VPC, allowing instances with public IPs to have DNS names
}

# Create public subnets within the VPC
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets_cidr)              # Create one subnet for each CIDR block in the 'public_subnets_cidr' list
  vpc_id            = aws_vpc.main.id                              # ID of the VPC where the subnet will be created
  cidr_block        = var.public_subnets_cidr[count.index]         # Assign each subnet a CIDR block from the list
  availability_zone = element(var.availability_zones, count.index) # Assign each subnet to an availability zone
}

# Create an Internet Gateway to allow internet access from within the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # ID of the VPC to which the Internet Gateway will be attached
}
