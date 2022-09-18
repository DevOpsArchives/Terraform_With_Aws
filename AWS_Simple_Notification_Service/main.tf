resource "aws_sns_topic" "sns" {
  name                        = var.sns_topic_name
  display_name                = var.sns_topic_name
  fifo_topic                  = true
  content_based_deduplication = true

  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : "${var.minDelayTarget}",
        "maxDelayTarget" : "${var.maxDelayTarget}",
        "numRetries" : "${var.numRetries}",
        "numMaxDelayRetries" : "${var.numMaxDelayRetries}",
        "numNoDelayRetries" : "${var.numNoDelayRetries}",
        "numMinDelayRetries" : "${var.numMinDelayRetries}",
        "backoffFunction" : "${var.backoffFunction}"
      }
    }
  })

  kms_master_key_id = var.kms_key_id

  tags = {
    Name    = var.sns_topic_name
    Billing = var.sns_topic_name
  }
}