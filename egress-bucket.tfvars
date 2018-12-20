bucket             			=   "egress_bucket"
acl     					=   ""
force_destroy    			=   ""
create_s3_notification      =   "true"
create_sns_notification     =   "true"
existing_sns_notification   =   "true"
id                  		=   ""
topic_arn                	=   ""
events		                =   ["s3:ObjectCreated:*"]
filter_prefix			    =   ".log"
filter_suffix		        =   ""
tags             =   {
      "Environment"="DEV"
      "Requestor"="ALI"
      "Department"="Cloud Architecture"
      "AppId"="S3-SNS"
      "AppName"="S3SNS"
}
sns_topic_resource              =   [] 
sns_topic_name		        =   "sns-egress-topic"
sns_topic_subscription_principal=   []
