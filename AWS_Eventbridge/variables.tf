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
# Event Bridge Variables
################################################################################
variable "event_archive_name" {
  type    = string
  default = "TestEventArchive"
}

variable "event_rule_name" {
  type        = string
  default     = "TestEventRule"
  description = "Name of the event rule"
}

variable "archive_retention" {
  type    = number
  default = 7
}

variable "event_expression" {
  type    = string
  default = "rate(1 minute)"
}

variable "retry_policy" {
  default = {
    max_retry_attempts       = 2
    max_event_age_in_seconds = 60
  }
}