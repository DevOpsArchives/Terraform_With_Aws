resource "aws_sqs_queue" "queue" {
  name                        = var.queue_name
  fifo_queue                  = var.is_fifo
  deduplication_scope         = var.deduplication_scope
  fifo_throughput_limit       = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication

  max_message_size = var.max_msg_size

  delay_seconds              = var.delay_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.msg_retention_seconds
  receive_wait_time_seconds  = var.recv_wait_time_seconds


  kms_master_key_id                 = var.kms_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_reuse_time

  tags = {
    Name    = var.queue_name
    Billing = var.queue_name
  }

  depends_on = [
    aws_sqs_queue.dql_queue
  ]
}

resource "aws_sqs_queue_redrive_policy" "queue_redrive_policy" {
  queue_url = aws_sqs_queue.queue.id

  redrive_policy = jsonencode({
    "deadLetterTargetArn" = "${aws_sqs_queue.dql_queue.arn}"
    "maxReceiveCount"     = "${var.max_recieve_count}"
  })

}

resource "aws_sqs_queue" "dql_queue" {
  name                        = var.dlq_queue_name
  fifo_queue                  = var.is_fifo
  
  deduplication_scope         = var.deduplication_scope
  fifo_throughput_limit       = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication

  max_message_size = var.max_msg_size

  delay_seconds              = var.delay_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.msg_retention_seconds
  receive_wait_time_seconds  = var.recv_wait_time_seconds
}

# Identify which source queues can use this queue as the dead-letter queue
resource "aws_sqs_queue_redrive_allow_policy" "dql_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })

}