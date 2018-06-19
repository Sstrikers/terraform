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

variable "availability_zones" {
  type = "list"
  default = []
}

variable "load_balancer_arn" {}
variable "target_group_arn" {}
variable "vpc_cidr_block" {}
variable "subnet01_cidr_block" {}
variable "subnet02_cidr_block" {}
variable "subnet03_cidr_block" {}
variable "subnet01_id" {}
variable "subnet02_id" {}
variable "subnet03_id" {}
variable "internet_gateway_id" {}
variable "vpc_default_route_table_id" {}

