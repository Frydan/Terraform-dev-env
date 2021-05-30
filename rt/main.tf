terraform {
  required_version = ">= 0.15"
}

resource "aws_route_table" "main_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "RouteTable"
    Environment = "Dev"
  }
}
/*
resource "aws_route_table_association" "main_rta_s1" {
  subnet_id      = var.subnets[0].id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_route_table_association" "main_rta_s2" {
  subnet_id      = var.subnets[1].id
  route_table_id = aws_route_table.main_rt.id
}

resource "aws_route_table_association" "main_rta_s3" {
  subnet_id      = var.subnets[2].id
  route_table_id = aws_route_table.main_rt.id
}
*/
resource "aws_route_table_association" "main_rta" {
    count = "${length(var.subnets.*.id)}"
    subnet_id = "${element(var.subnets.*.id, count.index)}"
    route_table_id = aws_route_table.main_rt.id
}