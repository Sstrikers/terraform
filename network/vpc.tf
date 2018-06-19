resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "main"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_default_route_table_id" {
  value = "${aws_vpc.main.default_route_table_id}"
}