terraform {
  required_version = ">= 0.15"
}


# Create main CodePipeline
resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = var.role_arn

  # Use created s3 bucket as main artifact store
  artifact_store {
    location = var.s3bucket
    type     = "S3"
  }

  ## TODO: ADD DEPENDS ON LIST ##

  # First stage sourcing code from CodeCommit repository
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["code"]

      configuration = {
        RepositoryName = var.RepositoryName
        BranchName     = var.BranchName
      }
    }
  }

  # Second stage deploying code from CodeCommit to EC2 instances
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["code"]
      version         = "1"

      configuration = {
        ApplicationName     = var.ApplicationName
        DeploymentGroupName = var.DeploymentGroupName
      }
    }
  }
}