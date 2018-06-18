variable "region" {
  default = "eu-central-1"
}
variable "ec2_image" {
  type = "map"
  default = {
    "eu-central-1" = "ami-9a91b371"
  }
}
