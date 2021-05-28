terraform {
  required_version = ">= 0.15"
}

# Create CodeDeploy application
resource "aws_codedeploy_app" "cd_app" {
  compute_platform = "Server"
  name             = "codedeployapp"
}

# Create CodeDeploy deployment group
resource "aws_codedeploy_deployment_group" "cd_dep_grp" {
  app_name              = aws_codedeploy_app.cd_app.name
  deployment_group_name = "codedeploydepgrp"
  service_role_arn      = var.arn

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  load_balancer_info {
    elb_info {
      name = var.elb_info
    }
  }



  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "webServer"
    }
  }
}