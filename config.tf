terraform {
  backend "s3" {
    bucket = "s3sns-dev"
    key    = "terraform.tfstate"
    region = "us-east-1"
 }
}
