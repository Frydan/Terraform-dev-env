terraform {
    required_version = ">= 0.15"
}

# Setup CodeCommit Repository
resource "aws_codecommit_repository" "codeCommit" {
  repository_name = "ProjectRepo"
  description     = "Main repository for project"

  tags = {
    Name = "CodeCommit"
    Environment = "Dev"
  }
}