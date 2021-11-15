# aws_cloudwatch_dashboard_alarm_custom_metrics_using_terraform

To get the dimensions:-
   aws cloudwatch list-metrics --region ap-south-1 --namespace AWS/SNS --metric-name NumberOfMessagesPublished --query 'Metrics[0].Dimensions[].Name'
