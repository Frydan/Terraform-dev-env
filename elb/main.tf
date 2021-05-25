terraform {
    required_version = ">= 0.15"
}

# Create a Load Balancer for Web Service Instances
resource "aws_elb" "elb_webServers" {
  name               = "webServers-loadBalancer"
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
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
    interval            = 30
  }

  instances                   = var.instances
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "webServersELB"
    Environment = "Dev"
  }
}