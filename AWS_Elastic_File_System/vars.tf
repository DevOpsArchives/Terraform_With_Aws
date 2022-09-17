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
  type    = bool
  default = true
}

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-008ec4c2da1e7fc30",
    "subnet-09141763c78825a7a",
    "subnet-03277a02e2c1e8833",
    "subnet-06113abdc0a6d323c",
    "subnet-0acc0dfb1321afa2e",
    "subnet-03e25ca9648e1f5c5"
  ]
  description = "Default Subnet ID for mount targe"
}