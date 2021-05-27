terraform {
  required_version = ">= 0.15"
}

# Setup CodeCommit Repository
resource "aws_codecommit_repository" "codeCommit" {
  repository_name = var.repository_name
  description     = "Main repository for project"

  tags = {
    Name        = "CodeCommit"
    Environment = "Dev"
  }
}