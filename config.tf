terraform {
  backend "s3" {
    bucket = "test"
    key    = "terraform.tfstate"
    region = "us-east-1"
 }
}
