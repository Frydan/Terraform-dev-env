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
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
}

# Create Main s3 bucket
# Returns object
module "s3_pipeline_bucket" {
  source = "./s3"
}

# Create Elastic Load Balancer for EC2 Apache instances
# Returns object
module "elb_module" {
  source              = "./elb"
  instances           = module.webservers_module.object[*].id
  elb_security_groups = module.sg_module.object_sg_ELB.id
}

# Create Security Group for EC2 Apache instances and Elastic Load Balancer
# Returns 2 objects: object_sg_HTTP_SSH & object_sg_ELB
module "sg_module" {
  source = "./sg"
}

# Create CodeCommit repository
# Returns object
module "codecommit_module" {
  source          = "./codecommit"
  repository_name = var.codecommit_repository_name
}

# Create role for EC2 web server instances
# Returns object
module "ws_role_module" {
  source = "./iam/wsrole"
}

# Create role for CodeDeploy
# Returns object
module "cd_role_module" {
  source = "./iam/cdrole"
}

# Create role for CodePipeline
# Returns object
module "cp_role_module" {
  source     = "./iam/cprole"
  bucket_arn = module.s3_pipeline_bucket.object.arn
}

# First create CodeDeploy application and then deployment group
# Returns 2 objects: object_app & object_dep_grp
module "cd_app_depgrp_module" {
  source = "./codedeploy"
  arn    = module.cd_role_module.object.arn
}

# Create main CodePipeline
module "codepipeline_module" {
  source              = "./codepipeline"
  role_arn            = module.cp_role_module.object.arn
  s3bucket            = module.s3_pipeline_bucket.object.bucket
  RepositoryName      = module.codecommit_module.object.repository_name
  BranchName          = var.BranchName
  ApplicationName     = module.cd_app_depgrp_module.object_app.name
  DeploymentGroupName = module.cd_app_depgrp_module.object_dep_grp.deployment_group_name
}

## TODO:  Jenkins for future build stage ##
/*
module "jenkins" {
  source = "./ec2/jenkins"
  security_groups = [module.sg_module.object_sg_Jenkins_SSH.name]
}
*/

# Create EC2 instances Apache web servers
# Returns object (list)
module "webservers_module" {
  source           = "./ec2/webservers"
  webservers_count = var.webservers_count
  key_name         = var.key_webservers
  security_groups  = [module.sg_module.object_sg_HTTP_SSH.name]
  role             = module.ws_role_module.object.name
}

# For future codeBuild
#output "jenkins_ip" {
#    value = module.jenkins.object.public_ip
#}

# Display IPs of created EC2 Apache web servers
output "webServers_ips" {
  value = module.webservers_module.object[*].public_ip
}

# Display DNS name of created Elastic Load Balancer
output "loadBalancer_dns_name" {
  value = module.elb_module.object.dns_name
}