variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Which AWS region should be used"
}

variable "key_name_webservers" {
  type        = string
  default     = "webserver-access"
  description = "Name of the SSH key pair You generated for webservers"
}

variable "shared_credentials_file" {
  type        = string
  default     = "/home/dzordzo/.aws/credentials"
  description = "Where AWS credenials files are stored locally"
}

variable "asg_subnets" {
  type        = list(any)
  default     = ["subnet-af4acde3", "subnet-d73174bd", "subnet-11a9196d"]
  description = "List of subnets where Auto Scaling Group will deploy EC2 web server instances"
}

variable "min_size_asg_webservers" {
  type        = number
  default     = 2
  description = "Minimal amount of EC2 web server instances"
}
variable "desired_capacity_asg_webservers" {
  type        = number
  default     = 2
  description = "Desired amount of EC2 web server instances"
}
variable "max_size_asg_webservers" {
  type        = number
  default     = 5
  description = "Maximum amount of EC2 web server instances"
}

variable "availability_zones_elb" {
  type        = list(any)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  description = "List of AZ-s which will be supported by Elastic Load Balancer"
}

variable "lc_image_id" {
  type        = string
  default     = "ami-043097594a7df80ec" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  description = "AMI to be used for EC2 web server instances"
}

variable "lc_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type to be used for EC2 web server instances"
}

variable "BranchName" {
  type        = string
  default     = "master"
  description = "Name of CodeCommit branch to be created"
}

variable "pipeline_name" {
  type        = string
  default     = "tf-test-pipeline"
  description = "Name of the CodePipeline to be created"
}

variable "codecommit_repository_name" {
  type        = string
  default     = "ProjectRepo"
  description = "Name of CodeCommit repository to be created"
}
