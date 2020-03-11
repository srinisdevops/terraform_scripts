
#resource "aws_s3_bucket" 
#  bucket = "my-tf-log-bucket-02272020"
#  acl    = "log-delivery-write"
#}

#--------------------------

provider "aws" {
   region = "us-east-2"
}

resource "aws_s3_bucket" "test_bucket-02272020" {
  bucket = "my-tf-test-bucket-02272020-1"
  acl    = "public-read"


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }


}

output "bucket-arn" {
	value = "${aws_s3_bucket.test_bucket-02272020.arn}"
}


output "bucket-id" {
	value = "${aws_s3_bucket.test_bucket-02272020.id}"
}

output "end-of-script" {
	value = "###########"
}

# --------------------------------




#  logging {
#      target_bucket = "${aws_s3_bucket.log_bucket-02272020.id}"
#      target_prefix = "log/"
#    }

#  tags = {
#    Name        = "My bucket"
#    Environment = "Dev"
#  }


#  website {
#	
#	index_document = "index.html"
#	error_document = "error.html"
#	}




