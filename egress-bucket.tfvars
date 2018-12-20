s3-egress-bucket   			=   "egress-bucket-devs3"
acl     					=   ""
force_destroy    			=   ""
events		                =   ["s3:ObjectCreated:*"]
filter_suffix		        =   ".log"
tags             =   {
      "Environment"="DEV"
      "Requestor"="ALI"
      "Department"="Cloud Architecture"
      "AppId"="S3-SNS"
      "AppName"="S3SNS"
}
sns-egress-notification     =   "dropzone-egress-tpc"
