provider "aws" {
  region     = "${var.region}"
}

module "network" {
  source = "./network"
  vpc_id = "${data.aws_vpc.selected.id}"
  subnet_list = ["${data.aws_subnet_ids.subnets.ids}"]
  security_group_list = ["${module.network.allow_http}", "${module.network.allow_ssh}"]
  load_balancer_arn = "${module.network.load_balancer_arn}"
  target_group_arn = "${module.network.target_group_arn}"
}

module "security" {
  source = "./security"
}

module "instances" {
  source = "./instances"
  availability_zones = ["${data.aws_availability_zones.available.names}"]
  target_group_arns = ["${module.network.target_group_arn}"]
  security_group_list = ["${module.network.allow_http}", "${module.network.allow_ssh}"]
  region = "${var.region}"
  key_name = "${module.security.key_name}"
  user_data = "${data.template_file.user_data.rendered}"
  image_id = "${data.aws_ami.amazon_linux.id}"
  launch_configuration_name = "${module.instances.launch_configuration_name}"
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



  
  
