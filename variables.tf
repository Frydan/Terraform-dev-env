variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Which AWS region should be used"
}

variable "key_webservers" {
  type        = string
  default     = "webserver-access"
  description = "Name of the SSH key pair You generated for webservers"
}

variable "shared_credentials_file" {
  type        = string
  default     = "/home/dzordzo/.aws/credentials"
  description = "Where AWS credenials files are stored locally"
}

variable "BranchName" {
  type        = string
  default     = "master"
  description = "Name of CodeCommit branch to be created"
}

variable "codecommit_repository_name" {
  type        = string
  default     = "ProjectRepo"
  description = "Name of CodeCommit repository to be created"
}

variable "webservers_count" {
  type        = number
  default     = 2
  description = "Number of EC2 Apache instances"
}
