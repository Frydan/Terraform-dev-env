variable "elb_security_group" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}

variable "subnets" {
  type = list(any)
}