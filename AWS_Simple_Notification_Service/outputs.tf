output "sns_topic_arn" {
  value       = aws_sns_topic.sns.arn
  description = "SNS Topic ARN"
}