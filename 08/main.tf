provider "aws" {
   region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "mybucket02222020"
    #key    = "tfstatefiles/terraform.tfstate"
    key    = "asg02/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "mylogbucket03132020"
  acl    = "log-delivery-write"
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-06b2e5950e8c41e0d"]
  subnets            = ["${var.subnet1}","${var.subnet2}","${var.subnet1}"]

  enable_deletion_protection = true

  access_logs {
    bucket  = "${aws_s3_bucket.log_bucket.bucket}"
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}



resource "aws_launch_configuration" "my_asc_01" {
  name = "my-asc-1"
  image_id = "${var.amiid}"
  security_groups = ["sg-06b2e5950e8c41e0d"]
  instance_type = "t2.micro"
  key_name = "${var.key_name}" 
  # Other params are not defined here because, image we are using has all that info.
  #user_data = "${file("user-data.txt")}"
}

resource "aws_autoscaling_group" "my_asg_01" {
  name = "my_asf_tf_01"
  max_size = "${var.max_count}"
  min_size = "${var.min_count}"
  desired_capacity ="${var.desired_count}"
  health_check_grace_period = "${var.hc_grace_period}"
  launch_configuration = "${aws_launch_configuration.my_asc_01.name}"
  wait_for_capacity_timeout = "${var.cap_timeout}"
  vpc_zone_identifier = ["${var.subnet1}", "${var.subnet2}"]
}

output "auto_Scaling_Group_ID" {
  value = "${aws_autoscaling_group.my_asg_01.id}"
}

output "Auto_Scaling_Launch_Config_ID" {
  value = "${aws_launch_configuration.my_asc_01.id}"
}

output "Auto_Scaling_Launch_Config_ARN" {
  value = "${aws_launch_configuration.my_asc_01.arn}"
}

output "End_of_the_Script" {
  value = "End of Script"
}
