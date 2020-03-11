
#resource "aws_s3_bucket" 
#  bucket = "my-tf-log-bucket-02272020"
#  acl    = "log-delivery-write"
#}

#--------------------------

resource "aws_s3_bucket" "test_bucket-02272020" {
  bucket = "my-tf-test-bucket-02272020"
  acl    = "public-read"
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




