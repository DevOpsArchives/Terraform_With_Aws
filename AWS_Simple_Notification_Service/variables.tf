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
  default = "eaa3ed72-51a7-4d4f-a5a5-dcb8dd387804"
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