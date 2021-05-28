terraform {
  required_version = ">= 0.15"
}

resource "aws_iam_instance_profile" "webServers_profile" {
  name = "webServers_profile"
  role = var.role
}

resource "aws_launch_configuration" "lc_webservers" {
  name_prefix = "webserver-"

  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.webServers_profile.name

  security_groups             = [var.security_group]
  associate_public_ip_address = true

  user_data = file("./scripts/webServer_install.sh")

  lifecycle {
    create_before_destroy = true
  }
}