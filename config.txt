terraform {
  backend "s3" {
    bucket = "s3sns-dev-platformconfig-us-east-1"
    key    = "s3sns-dev/s3sns-slave-role/terraform.tfstate"
    region = "us-east-1"
 }
}
