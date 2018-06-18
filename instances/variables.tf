variable "availability_zones" {
  type = "list"
  default = []
}

variable "target_group_arns" {
  type = "list"
  default = []
}

variable "security_group_list" {
  type = "list"
  default = []
}

variable "launch_configuration" {
}

variable "region" {
}

variable "key_name" {
}

variable "user_data" {
}