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