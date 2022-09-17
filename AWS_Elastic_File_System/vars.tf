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
# EFS Variables
################################################################################
variable "efs_name" {
  type    = string
  default = "TestEFS"
}

variable "performance_mode" {
  type    = string
  default = "generalPurpose"
}

variable "throughput_mode" {
  type    = string
  default = "bursting"
}

variable "transition_to_ia_time" {
  type    = string
  default = "AFTER_60_DAYS"
}

variable "backup_policy_status" {
  type    = string
  default = "ENABLED"
}

variable "efs_encryption" {
  type = bool
  default = true
}