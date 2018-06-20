resource "aws_cloudwatch_metric_alarm" "high_cpu_load" {
  alarm_name          = "high-cpu-load"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${var.autoscaling_group_name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${var.autoscaling_policy_add_arn}"]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_load" {
  alarm_name          = "low-cpu-load"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "20"

  dimensions {
    AutoScalingGroupName = "${var.autoscaling_group_name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${var.autoscaling_policy_remove_arn}"]
}