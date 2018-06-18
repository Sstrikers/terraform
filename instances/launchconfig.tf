resource "aws_launch_configuration" "web_srv" {
  name          = "WebSRV"
  image_id      = "${lookup(var.ec2_image, var.region)}"
  user_data = "${data.template_file.user_data.rendered}" 
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_http.id}"]
  key_name = "${aws_key_pair.ssh_access.key_name}"
}