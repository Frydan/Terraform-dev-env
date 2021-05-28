variable "security_groups" {
  type = list(any)
}
variable "webservers_count" {
  type = number
}

variable "key_name" {
  type = string
}

variable "role" {
  type = string
}