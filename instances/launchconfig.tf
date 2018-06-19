resource "aws_launch_configuration" "web_srv" {
  name          = "WebSRV"
  image_id      = "${var.image_id}"
  user_data = "${var.user_data}" 
  instance_type = "t2.micro"
  security_groups = ["${var.security_group_list}"]
  key_name = "${var.key_name}"
}

output "launch_configuration_name" {
  value = "${aws_launch_configuration.web_srv.name}"
}