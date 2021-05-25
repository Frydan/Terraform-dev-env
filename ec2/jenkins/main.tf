terraform {
    required_version = ">= 0.15"
}

# Create jenkins instance 
resource "aws_instance" "jenkins" {
    ami             = "ami-043097594a7df80ec"
    instance_type   = "t2.micro"
    availability_zone = "eu-central-1a"
    key_name = "jenkins-access"
    user_data ="${file("./scripts/jenkins_install.sh")}"
    security_groups = var.security_groups
    tags = {
        Name = "Jenkins"
        Environment = "Dev"
    }

}