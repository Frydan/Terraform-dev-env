variable "shared_credentials_file" {
  type = string
  default = "/home/dzordzo/.aws/credentials"
  description = "Where AWS credenials files are stored locally"
}

variable "BranchName" {
  type = string
  default = "master"
}

variable "codecommit_repository_name" {
  type = string
  default = "ProjectRepo"
}