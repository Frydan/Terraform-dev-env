variable "load_balancer" {
  type = string
}

variable "launch_configuration" {
  type = string
}

variable "asg_subnets" {
  type = list(any)
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}