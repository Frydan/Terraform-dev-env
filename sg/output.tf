 output "sg_Jenkins_SSH_name" {
     value = aws_security_group.sg_Jenkins_SSH.name
 }

 output "sg_HTTP_SSH_name" {
     value = aws_security_group.sg_HTTP_SSH.name
 }
