terraform {
  required_version = ">= 0.15"
  backend "s3" {
    bucket  = "df-tfstate-s3-bucket"
    region  = "eu-central-1"
    encrypt = true
    key     = "terraform.tfstate"
  }
}