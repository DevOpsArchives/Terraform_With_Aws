output "queue_url" {
  value = aws_sqs_queue.queue.url
}

output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}