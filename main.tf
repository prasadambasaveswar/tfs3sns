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
 
resource "aws_s3_bucket_notification" "bucket_notification_existing_sns" {
  count = "${var.create_s3_notification && var.existing_sns_notification ? 1 : 0}"
  bucket = "${aws_s3_bucket.s3_bucket.id}"
  topic {
    topic_arn      = "${var.topic_arn}"
    events         = "${var.events}"
    filter_prefix  = "${var.filter_prefix}"
    filter_suffix  = "${var.filter_suffix}"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification_new_sns" {
  count = "${var.create_s3_notification && var.create_sns_notification ? 1 : 0}"
  bucket = "${aws_s3_bucket.s3_bucket.id}"
  topic {
    topic_arn = "${aws_sns_topic.s3-topic.arn}"
    events         = "${var.events}"
    filter_prefix  = "${var.filter_prefix}"
    filter_suffix  = "${var.filter_suffix}"
  }
}


resource "aws_sns_topic" "s3-topic" {
  count = "${var.create_s3_notification && var.create_sns_notification ? 1 : 0}"
  name = "${var.sns_topic_name}"
  policy = <<POLICY
{
    "Version":"2008-10-17",
    "Id": "SNS-S3Topic-Policy",
    "Statement":[
      {
        "Effect": "Allow",
        "Sid": "SNSPolicy",
        "Principal": {
            "Service": "s3.amazonaws.com"
            },
        "Action": "SNS:Publish",
        "Resource": ${jsonencode(var.sns_topic_resource)},
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3_bucket.arn}"}
        }
      }
    ]
}
POLICY
}
