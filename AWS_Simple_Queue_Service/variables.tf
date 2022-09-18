################################################################################
# General Variables
################################################################################
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region where our infrastructure is deployed"
}

variable "profile" {
  type        = string
  default     = "self"
  description = "AWS Profile"
}

################################################################################
# SQS Variables
################################################################################

variable "queue_name" {
  type=string
  default = "TestQueue.fifo"
}

variable "is_fifo" {
  type=bool
  default = true
}

variable "deduplication_scope" {
  type = string
  default = "messageGroup"
}

variable "fifo_throughput_limit" {
  type = string
  default = "perMessageGroupId"
}

variable "content_based_deduplication" {
  type = bool
  default = true
}
variable "max_msg_size" {
  type = number
  default = 131072
}

variable "delay_seconds" {
  type = number
  default = 0
}

variable "visibility_timeout_seconds" {
  type = number
  default = 300
}

variable "msg_retention_seconds" {
  type = number
  default = 604800
}

variable "recv_wait_time_seconds" {
  type = number
  default = 5
}

variable "max_recieve_count" {
  type = number
  default = null
}

variable "is_encryption_enabled" {
  type = bool
  default=true
}
variable "kms_key_id" {
  type = string
  default = "5163017c-e55f-4e0e-8b4f-0c74c7a60319"
}

variable "kms_data_reuse_time" {
 type=number
 default = 300 
}