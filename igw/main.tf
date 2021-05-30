terraform {
  required_version = ">= 0.15"
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "InternetGateway"
    Environment = "Dev"
  }
}