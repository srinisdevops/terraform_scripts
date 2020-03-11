

provider "aws" {
	region = "us-east-2"
}


terraform {
  backend "s3" {
    bucket = "mybucket02222020"
    #key    = "tfstatefiles/terraform.tfstate"
    key    = "project1/terraform.tfstate"
    region = "us-east-2"
  }
}



resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpCreatedFromTf01"
  }
}


output "VPC id" {
  value = "${aws_vpc.myvpc.id}"
}


resource "aws_security_group" "allow_ssh" {
  name = "MySg01"
  description = "Allow ssh inbound traffic"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
     Name = "MySg01-tf"
  }
}

output "SecurityGroupId" {
    value = "${aws_security_group.allow_ssh.id}"
}


resource "aws_instance" "srini_servers" {
	#ami = "ami-0fc20dd1da406780b"
	ami = "lookup(var.amiid, var.region)"
	count = "${var.instance_count}"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
	key_name = "${var.key_name}"

	tags = {
    		#Name = "tf-example"
    		Name = "terraformInst--${count.index + 1}"
  		}
	user_data = "${file("user-data.txt")}"

}
output "public_ip" {
	value = "${aws_instance.srini_servers.*.public_ip}"
		}

