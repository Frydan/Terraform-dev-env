terraform {
  required_version = ">= 0.15"
}

resource "aws_iam_instance_profile" "webServers_profile" {
  name = "webServers_profile"
  role = var.role
}

# Create Web Servers instances
resource "aws_instance" "webServers" {
  count                = var.webservers_count
  ami                  = "ami-043097594a7df80ec"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.webServers_profile.name
  key_name             = var.key_name
  user_data            = file("./scripts/webServer_install.sh")
  security_groups      = var.security_groups
  tags = {
    Name        = "webServer"
    Environment = "Dev"
  }
}