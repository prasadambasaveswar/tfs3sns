terraform {
  backend "s3" {
    bucket = "marklogictest"
    key    = "terraform.tfstate"
    region = "us-east-1"
 }
}
