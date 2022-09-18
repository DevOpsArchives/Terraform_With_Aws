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
# SNS  Variables
################################################################################
variable "sns_topic_name" {
  type    = string
  default = "TestSNSTopic.fifo"
}

variable "kms_key_id" {
  type    = string
  default = "5163017c-e55f-4e0e-8b4f-0c74c7a60319"
}

variable "minDelayTarget" {
  type    = number
  default = 20
}

variable "maxDelayTarget" {
  type    = number
  default = 20
}

variable "numRetries" {
  type    = number
  default = 3
}

variable "numMaxDelayRetries" {
  type    = number
  default = 0
}

variable "numNoDelayRetries" {
  type    = number
  default = 0
}

variable "numMinDelayRetries" {
  type    = number
  default = 0
}

variable "backoffFunction" {
  type    = string
  default = "linear"
}

variable "topic_subscription_protocol" {
  type    = string
  default = "sqs"
}

variable "topic_subscription_endpoint" {
  type    = string
  default = ""
  description = "If Skip subscription is not flase this a value needs to be here or though cli"
}

variable "skip_subscription" {
  type = bool
  default = false
}