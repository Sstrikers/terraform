resource "aws_autoscaling_group" "ASGWebSRV" {
  name                      = "ASG-WebSRV"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 3
  availability_zones		= ["${var.availability_zones}"]
  force_delete              = true
  launch_configuration      = "${var.launch_configuration_name}"
  target_group_arns			= ["${var.target_group_arns}"]
}