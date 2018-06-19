resource "aws_internet_gateway" "gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "main"
  }
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.gateway.id}"
}