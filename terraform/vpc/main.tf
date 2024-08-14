resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[0]
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[1]
  availability_zone = var.availability_zones[1]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
