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

#module "codecommit" {
#  source = "./codecommit"
#}

module "cdrole" {
  source = "./iam/cdrole"
  bucket_arn = module.s3_pipeline_bucket.object.arn
}

module "cd_app_depgrp" {
  source = "./codedeploy"
  arn = module.cdrole.object.arn
}
module "codepipeline" {
  source = "./codepipeline"
  s3bucket = module.s3_pipeline_bucket.object.bucket
  arn = module.s3_pipeline_bucket.object.arn
  RepositoryName = var.codecommit_repository_name #module.codecommit.object.repository_name
  BranchName = var.BranchName
  ApplicationName = module.cd_app_depgrp.object_app.name
  DeploymentGroupName = module.cd_app_depgrp.object_dep_grp.deployment_group_name  
}

# For future codeBuild
#module "jenkins" {
#  source = "./ec2/jenkins"
#  security_groups = [module.sg-module.object_sg_Jenkins_SSH.name]
#}

module "webservers" {
  source = "./ec2/webservers"
  security_groups = [module.sg-module.object_sg_HTTP_SSH.name]
}

# For future codeBuild
#output "jenkins_ip" {
#    value = module.jenkins.object.public_ip
#}

output "webServers_ips" {
    value = module.webservers.object[*].public_ip
}

output "loadBalancer_dns_name" {
    value = module.elb-module.object.dns_name
}