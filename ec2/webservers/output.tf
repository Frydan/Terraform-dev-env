output "public_ip" {
    value = aws_instance.webServers[*].public_ip
}
output "ids" {
    value = aws_instance.webServers[*].id
}