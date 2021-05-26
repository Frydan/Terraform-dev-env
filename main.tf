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
  shared_credentials_file = var.shared_credentials_file
}

module "s3_pipeline_bucket" {
  source = "./s3"
}

module "elb-module" {
  source = "./elb"
  instances = module.webservers.object[*].id
}


module "sg-module" {
  source = "./sg"
}

#module "codeCommit" {
#  source = "./codecommit"
#}

#module "cdrole" {
#  source = "./iam/cdrole"
#  bucket_arn = module.s3_pipeline_bucket.arn
#}

#module "cd_app_depgrp" {
#  source = "./codedeploy"
#  arn = module.cdrole.arn_cd
  #elb = module.elb
#}

#module "cp" {
#  source = "./codepipeline"
#  s3bucket = module.s3_pipeline_bucket
#}

module "jenkins" {
  source = "./ec2/jenkins"
  security_groups = [module.sg-module.object_sg_Jenkins_SSH.name]
}

module "webservers" {
  source = "./ec2/webservers"
  security_groups = [module.sg-module.object_sg_HTTP_SSH.name]
}

output "jenkins_ip" {
    value = module.jenkins.object.public_ip
}

output "webServers_ips" {
    value = module.webservers.object[*].public_ip
}

output "loadBalancer_dns_name" {
    value = module.elb-module.object.dns_name
}