provider "aws" {
  region     = "${var.region}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["137112412989"]
}

data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "selected" {}

data "aws_subnet_ids" "subnets" {
  vpc_id   = "${data.aws_vpc.selected.id}"
}

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

resource "aws_launch_configuration" "web_srv" {
  name          = "WebSRV"
  image_id      = "${lookup(var.ec2_image, var.region)}"
  user_data = "${data.template_file.user_data.rendered}" 
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_http.id}"]
  key_name = "${aws_key_pair.ssh_access.key_name}"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow ssh"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
   tags {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "allow_http"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
   tags {
    Name = "allow_http"
  }
}
 
resource "aws_key_pair" "ssh_access" {
  key_name   = "ssh_access"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTuSUxr4Udrx5q3LZPfqUo202LHntq2s30rZJa48C9MPFVuXu/n+Rd/pnjL3osMag7xDYQmtpqQ6umTbCYuTSWLfzBhifFgjly1AnflfnSxDQChfhqqTk3s8aRa3CSJIgGRcfXGLz9XzSR8CU3alH3SI8fuf1sSuhpa+ENsjs71hyT7QQEwFW77vktvn1gIXu8Rhgy68I2zZMcS6SlKooP41/6yrCHwLC3cd4uky2HowOHCQCmTK5XxMn7o9FYyxpZl/7qGpPGSvD079iKiGeQhJ4zE5dtesEklXJly2kTR4cJ6XUgewKOyW4uI+mF9RWY790N+F39U4HFEVV7E3N9 SSH Access"
}  
  
resource "aws_lb" "alb_websrv" {
  name               = "ALB-WebSRV"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_http.id}"]
  subnets 	 		 = ["${data.aws_subnet_ids.subnets.ids}"]
  
  tags {
    Name = "alb_websrv"
  }
}

resource "aws_lb_listener" "listener_websrv" {
  load_balancer_arn = "${aws_lb.alb_websrv.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    target_group_arn = "${aws_lb_target_group.tg_web_srv.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tg_web_srv" {
  name     = "TG-WebSRV"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.selected.id}"
  health_check {
    path	 = "/index.html"
	interval = 30
	healthy_threshold   = 2
    unhealthy_threshold = 2
	timeout = 6
	matcher = "200"
  }
}

  
  
