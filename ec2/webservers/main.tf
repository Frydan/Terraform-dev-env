terraform {
  required_version = ">= 0.15"
}

# Create Web Servers instances
resource "aws_instance" "webServers" {
  count           = var.webservers_count
  ami             = "ami-043097594a7df80ec"
  instance_type   = "t2.micro"
  key_name        = "webserver-access"
  user_data       = file("./scripts/webServer_install.sh")
  security_groups = var.security_groups
  tags = {
    Name        = "webServer"
    Environment = "Dev"
  }
}