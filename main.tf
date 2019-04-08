#s3 bucket

provider "aws" {
  region = "us-east-1"
}

#s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket                 = "${var.bucket}"
  acl                    = "${var.acl}"
  tags                   = "${var.tags}"
  force_destroy          = "${var.force_destroy}"
  versioning = "${var.versioning}"
  lifecycle_rule = "${var.lifecycle_rule}"
  logging = "${var.logging}"
 }
 
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"
}
