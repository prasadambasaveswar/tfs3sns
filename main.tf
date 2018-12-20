#s3 bucket

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "egress-bucket" {
  bucket                 = "${var.s3-egress-bucket}"
  acl                    = "${var.acl}"
  tags                   = "${var.tags}"
  force_destroy          = "${var.force_destroy}"
  versioning = "${var.versioning}"
  lifecycle_rule = "${var.lifecycle_rule}"
  logging = "${var.logging}"
}

resource "aws_sns_topic" "topic" {
  name = "${var.sns-egress-notification}"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {"AWS":"*"},
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:${var.sns-egress-notification}",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.egress-bucket.arn}"}
        }
    }]
}
POLICY
}

resource "aws_s3_bucket_notification" "egress_bucket_notification" {
  bucket = "${aws_s3_bucket.egress-bucket.id}"

  topic {
    topic_arn     = "${aws_sns_topic.topic.arn}"
    events        = "${var.events}"
    filter_suffix = "${var.filter_suffix}"
  }
}
