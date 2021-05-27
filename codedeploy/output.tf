output "object_app" {
  value = aws_codedeploy_app.cd_app
}

output "object_dep_grp" {
  value = aws_codedeploy_deployment_group.cd_dep_grp
}
