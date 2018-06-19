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

variable "region" {
}

variable "key_name" {
}

variable "user_data" {
}

variable "image_id" {
}

variable "launch_configuration_name" {
}

variable "subnet01_id" {
}
variable "subnet02_id" {
}
variable "subnet03_id" {
}