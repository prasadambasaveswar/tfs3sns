variable "bucket" {
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
variable "create_s3_notification" {
  default = false
}
variable "create_sns_notification" {
  default = false
}
variable "existing_sns_notification" {
  default = false
}

variable "id" {
  default = ""
}

variable "topic_arn" {
  default = ""
}


variable "events" {
  type = "list"
  default = ["s3:ObjectCreated:*"]
}


variable "filter_prefix" {
  default = ""
}

variable "filter_suffix" {
  default = ""
}


##sns topic policy
variable "sns_topic_resource"{
  type = "list"
  default = []
}

variable "sns_topic_name"{
  default = ""
}

variable "sns_topic_subscription_principal"{
  type = "list"
  default = []
}
