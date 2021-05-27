terraform {
  required_version = ">= 0.15"
}

resource "aws_s3_bucket" "s3_pipeline_bucket" {
  bucket = "df-aws-test-pipeline"
  acl    = "private"
  force_destroy = true
  
  versioning {
    enabled = true
  }

  tags = {
    Name        = "s3_bucket"
    Environment = "Dev"
  }
}

