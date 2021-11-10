provider "aws" {
  region = "ap-south-1"
}


variable "ec2-instance" {
  type = string
  default = "i-00318a591cb304511"
}


resource "aws_cloudwatch_dashboard" "dashboard-terraform" {
  dashboard_name = "terra-cloudwatch-dashboard-1"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "CWAgent",
            "disk_used_percent",
            "InstanceId",
            "${var.ec2-instance}",
            "path",
             "/",
            "device",
            "xvda1",
            "fstype",
            "xfs"
          ]
        ],
        "period": 180,
        "stat": "Average",
        "region": "ap-south-1",
        "stacked": true,
        "title": "EC2 Instance Disk Used"
      }
    }
    
    
  ]
}
EOF

}


# resource "aws_instance" "web" {
#   ami           = "ami-041db4a969fe3eb68"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

# output "private_ip" { value = "${aws_instance.web.public_ip}" }

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "This metric monitors ec2 disk utilization"
  actions_enabled           = "true"
  alarm_actions             = ["arn:aws:sns:ap-south-1:269763233488:Default_CloudWatch_Alarms_Topic"]
  insufficient_data_actions = []
  #treat_missing_data = "notBreaching"

   dimensions = {
     path = "/"
    InstanceId = "${var.ec2-instance}"
     device = "xvda1"
    
    fstype = "xfs"
   
   
  }
}