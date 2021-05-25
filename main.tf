terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = "/home/dzordzo/.aws/credentials"
}


module "elb-module" {
  source = "./elb"
  instances = module.webservers.ids
}


module "sg-module" {
  source = "./sg"
}

module "codeCommit" {
  source = "./codecommit"
}


module "jenkins" {
  source = "./ec2/jenkins"
  security_groups = [module.sg-module.sg_Jenkins_SSH_name]
}

module "webservers" {
  source = "./ec2/webservers"
  security_groups = [module.sg-module.sg_HTTP_SSH_name]
}

output "jenkins_ip" {
    value = module.jenkins.public_ip
}

output "webServers_ips" {
    value = [for i in module.webservers.public_ip : i[*]]
}

output "loadBalancer_dns_name" {
    value = module.elb-module.dns_name
}