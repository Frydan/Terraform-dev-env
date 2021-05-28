## TODO:  Jenkins for future build stage ##
/*
output "jenkins_ip" {
    value = module.jenkins.object.public_ip
}
*/

# Display IPs of created EC2 Apache web servers
output "webServers_ips" {
  value = module.webservers_module.object[*].public_ip
}

# Display DNS name of created Elastic Load Balancer
output "loadBalancer_dns_name" {
  value = module.elb_module.object.dns_name
}


# Display CodeCommit HTTPS url
output "CodeCommit_HTTPS_url" {
  value = module.codecommit_module.object.clone_url_http
}