resource "aws_autoscaling_group" "ASGWebSRV" {
  name                      = "ASG-WebSRV"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 3
  availability_zones		= ["${data.aws_availability_zones.available.names}"]
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.web_srv.name}"
  target_group_arns			= ["${aws_lb_target_group.tg_web_srv.arn}"]
}