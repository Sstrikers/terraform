resource "aws_default_route_table" "route" {
  default_route_table_id = "${var.vpc_default_route_table_id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.internet_gateway_id}"
  }  
  
}