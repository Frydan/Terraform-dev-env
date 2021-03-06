terraform {
  required_version = ">= 0.15"
}

# Create a Load Balancer for Web Service Instances
resource "aws_elb" "elb_webServers" {
  name = "webServers-loadBalancer"
  security_groups = [var.elb_security_group]
  subnets         = var.subnets

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 100

  tags = {
    Name        = "webServersELB"
    Environment = "Dev"
  }
}