terraform {
  required_version = ">= 0.15"
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name        = "Subnet"
    Environment = "Dev"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name        = "Subnet"
    Environment = "Dev"
  }
}

resource "aws_subnet" "subnet-3" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name        = "Subnet"
    Environment = "Dev"
  }
}
