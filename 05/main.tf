
provider "aws" {
	region = us-east-2 
}

variable "index" {
	default = 0
}

locals {
	list = [ [1,2,3] ,
                 [[1,2],[3]],
                 [],
                 [1]
                 ]
}

output "funtions" {
	value = "${var.index}"
}

output "chunklist" {
	value = "${chunklist(local.list[0],1)}"
}






