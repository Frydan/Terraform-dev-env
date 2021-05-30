variable "vpc_id" {
  type = string
}

variable "gateway_id" {
  type = string
}

variable "subnets" {
  type = list(any)
}