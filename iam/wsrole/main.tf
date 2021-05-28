terraform {
  required_version = ">= 0.15"
}

resource "aws_iam_role" "webserver_deploy_role" {
  name = "webserver_deploy_role"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name        = "WebServerRole"
    Type        = "Role"
    Environment = "Dev"
  }
}

# Create attachment for this role
resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforAWSCodeDeploy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
  role       = aws_iam_role.webserver_deploy_role.name
}