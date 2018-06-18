data "aws_vpc" "selected" {}
data "aws_subnet_ids" "subnets" {
  vpc_id   = "${data.aws_vpc.selected.id}"
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

  
  
