variable "region" {
  default = "eu-central-1"
}
/*
variable "ec2_image" {
  type = "map"
  default = {
    "eu-central-1" = "ami-9a91b371"
  }
}
*/
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet01_cidr_block" {
  default = "10.0.1.0/24"
}
variable "subnet02_cidr_block" {
  default = "10.0.2.0/24"
}
variable "subnet03_cidr_block" {
  default = "10.0.3.0/24"
}




