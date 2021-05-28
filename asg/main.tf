terraform {
  required_version = ">= 0.15"
}

resource "aws_autoscaling_group" "asg_webServers" {
  name = "asg_webServers"

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  health_check_type = "ELB"
  load_balancers    = [var.load_balancer]

  launch_configuration = var.launch_configuration

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  vpc_zone_identifier = var.asg_subnets

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "webServer"
    propagate_at_launch = true
  }

}