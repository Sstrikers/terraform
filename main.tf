#Use AWS provider
provider "aws" {
  region     = "${var.region}"
}

#Create VPC, GW, Route table, Security Groups, Application Load Balancer
module "network" {
  source = "./network"
  vpc_id = "${module.network.vpc_id}"
  subnet_list = ["${module.network.subnet01_id}", "${module.network.subnet02_id}", "${module.network.subnet03_id}"]
  security_group_list = ["${module.network.allow_http}", "${module.network.allow_ssh}"]
  load_balancer_arn = "${module.network.load_balancer_arn}"
  target_group_arn = "${module.network.target_group_arn}"
  
  vpc_cidr_block = "${var.vpc_cidr_block}"
  internet_gateway_id = "${module.network.internet_gateway_id}"
  subnet01_cidr_block = "${var.subnet01_cidr_block}"
  subnet02_cidr_block = "${var.subnet02_cidr_block}"
  subnet03_cidr_block = "${var.subnet03_cidr_block}"
  subnet01_id = "${module.network.subnet01_id}"
  subnet02_id = "${module.network.subnet02_id}"
  subnet03_id = "${module.network.subnet03_id}"
  vpc_default_route_table_id = "${module.network.vpc_default_route_table_id}"
}

#Public keys
module "security" {
  source = "./security"
}

#Create autoscale group 
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
  subnet01_id = "${module.network.subnet01_id}"
  subnet02_id = "${module.network.subnet02_id}"
  subnet03_id = "${module.network.subnet03_id}"
}

#Find the latest image of amazon linux image
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["137112412989"]
}
# Get the bash script for remote provision
data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"
}
#Get all available availability zones in current region
data "aws_availability_zones" "available" {}




  
  
