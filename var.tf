variable "s3-egress-bucket" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  }

variable "versioning"{
  default = []
  type = "list"
}

variable "lifecycle_rule"{
  default = []
  type = "list"
}

variable "logging"{
  default = []
  type = "list"
}


variable "acl" {
  description = "The canned ACL to apply"
  default = "private"
}


variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     = false
}


variable "tags" {
  description = "Specifies object tags key and value."
  type = "map"
  default = {}
}

##variables for s3 bucket notifications

variable "sns-egress-notification" {
  description = "sns engress notification"
}

variable "events" {
  type = "list"
  default = ["s3:ObjectCreated:*"]
}

variable "filter_suffix" {
  default = ""
}
