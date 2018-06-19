resource "aws_subnet" "subnet01" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet01_cidr_block}"
  availability_zone = "eu-central-1a"

  tags {
    Name = "subnet01"
  }
}
output "subnet01_id" {
  value = "${aws_subnet.subnet01.id}"
}
resource "aws_subnet" "subnet02" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet02_cidr_block}"
  availability_zone = "eu-central-1b"

  tags {
    Name = "subnet02"
  }
}
output "subnet02_id" {
  value = "${aws_subnet.subnet02.id}"
}
resource "aws_subnet" "subnet03" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet03_cidr_block}"
  availability_zone = "eu-central-1c"
  
  tags {
    Name = "subnet03"
  }
}
output "subnet03_id" {
  value = "${aws_subnet.subnet03.id}"
}