resource "aws_sqs_queue" "queue" {
  name = var.queue_name
  fifo_queue = var.is_fifo
  deduplication_scope = var.deduplication_scope
  fifo_throughput_limit = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication
  
  max_message_size = var.max_msg_size

  delay_seconds = var.delay_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds = var.msg_retention_seconds
  receive_wait_time_seconds = var.recv_wait_time_seconds

  redrive_allow_policy = jsonencode({
    "deadLetterTargetArn" = "${aws_sqs_queue.dql_queue.arn}"
    "maxRecieveCount" = "${var.max_recieve_count}"
  })

sqs_managed_sse_enabled = var.is_encryption_enabled
kms_master_key_id = var.kms_key_id
kms_data_key_reuse_period_seconds = var.kms_data_reuse_time

  tags = {
    Name = var.queue_name
    Billing = var.queue_name
  }

  depends_on = [
    aws_sqs_queue.dql_queue
  ]
}
