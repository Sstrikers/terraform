resource "aws_autoscaling_group" "asg_websrv" {
  name                      = "asg-websrv"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 3
  vpc_zone_identifier		= ["${var.subnet01_id}", "${var.subnet02_id}", "${var.subnet03_id}"]
  force_delete              = true
  launch_configuration      = "${var.launch_configuration_name}"
  target_group_arns			= ["${var.target_group_arns}"]
}