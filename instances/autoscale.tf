resource "aws_autoscaling_group" "asg_websrv" {
  name                      = "asg-websrv"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 3
  default_cooldown          = 180
  health_check_grace_period = 90
  vpc_zone_identifier		= ["${var.subnet01_id}", "${var.subnet02_id}", "${var.subnet03_id}"]
  force_delete              = true
  launch_configuration      = "${var.launch_configuration_name}"
  target_group_arns			= ["${var.target_group_arns}"]
}

output "autoscalling_group_name" {
  value = "${aws_autoscaling_group.asg_websrv.name}"
}

resource "aws_autoscaling_policy" "add_by_cpu_load" {
  name                   = "add-by-cpu"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  policy_type 			 = "SimpleScaling"
  
  autoscaling_group_name = "${var.autoscalling_group_name}"
}

output "autoscaling_policy_add_arn" {
  value = "${aws_autoscaling_policy.add_by_cpu_load.arn}"
}

resource "aws_autoscaling_policy" "remove_by_cpu_load" {
  name                   = "remove-by-cpu"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  policy_type 			 = "SimpleScaling"
  
  autoscaling_group_name = "${var.autoscalling_group_name}"
}

output "autoscaling_policy_remove_arn" {
  value = "${aws_autoscaling_policy.remove_by_cpu_load.arn}"
}

resource "aws_autoscaling_schedule" "minimal" {
  scheduled_action_name  = "minimal"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence			 = "0 0 * * *"
  autoscaling_group_name = "${var.autoscalling_group_name}"
}

resource "aws_autoscaling_schedule" "normal" {
  scheduled_action_name  = "normal"
  max_size               = 4
  min_size               = 2
  desired_capacity       = 3
  recurrence			 = "0 8 * * *"
  autoscaling_group_name = "${var.autoscalling_group_name}"
}