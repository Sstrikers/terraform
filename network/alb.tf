data "aws_vpc" "selected" {}
data "aws_subnet_ids" "subnets" {
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb" "alb_websrv" {
  name               = "ALB-WebSRV"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_group_list}"]
  subnets 	 		 = ["${var.subnet_list}"]
  
  tags {
    Name = "alb_websrv"
  }
}

output "load_balancer_arn" {
  value = "${aws_lb.alb_websrv.arn}"
}

resource "aws_lb_listener" "listener_websrv" {
  load_balancer_arn = "${var.load_balancer_arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tg_web_srv" {
  name     = "TG-WebSRV"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  health_check {
    path	 = "/index.html"
	interval = 30
	healthy_threshold   = 2
    unhealthy_threshold = 2
	timeout = 6
	matcher = "200"
  }
}

output "target_group_arn" {
  value = "${aws_lb_target_group.tg_web_srv.arn}"
}
  
  
