variable "vpc_id" {
}

variable "subnet_list" {
  type = "list"
  default = []
}

variable "security_group_list" {
  type = "list"
  default = []
}

variable "load_balancer_arn" {
}

variable "target_group_arn" {
}
