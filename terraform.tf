

provider "aws" {
	region = "us-east-2"
}

resource "aws_instance" "srini_servers" {
	ami = "ami-0fc20dd1da406780b"
	#ami = "lookup(var.amiid, var.region)"
	count = "${var.instance_count}"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${var.security_group}"]
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
resource "null_resource" "myPublicIps" {
count = "${var.instance_count}"
provisioner "local-exec" {
      command = "echo '${element(aws_instance.srini_servers.*.public_ip, count.index)}' >> hosts1"
}
}


resource "aws_s3_bucket" "log_bucket-02272020" {
  bucket = "my-tf-log-bucket-02272020"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "test_bucket-02272020" {
  bucket = "my-tf-test-bucket-02272020"
  acl    = "public-read"

  logging {
      target_bucket = "${aws_s3_bucket.log_bucket-02272020.id}"
      target_prefix = "log/"
    }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }


  website {
	
	index_document = "index.html"
	error_document = "error.html"
	}

}


# website {
#	indes_document = "index.html"
#	error_document = "error.html"}


