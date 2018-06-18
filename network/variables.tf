variable "vpc_id" {
}

variable "security_group_list" {
  type = "list"
  default = []
}

variable "subnet_list" {
  type = "list"
  default = []
}

