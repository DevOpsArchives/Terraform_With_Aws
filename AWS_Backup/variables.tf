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
# Backup  Variables
################################################################################
variable "vault_name" {
  type    = string
  default = "TestVault"
}

variable "rule_name" {
  type    = string
  default = "TestBackupRule"
}

variable "backup_plan_name" {
  type    = string
  default = "TestBackupPlan"
}

variable "schedule_exp" {
  type    = string
  default = "cron(0 12 * * ? *)"
}

variable "continuous_backup" {
  type    = bool
  default = true
}

variable "start_window" {
  type    = number
  default = 480
}

variable "completion_window" {
  type    = number
  default = 2880
}

variable "is_resource_enabled" {
  type    = bool
  default = true
}

variable "retention_period" {
  type    = number
  default = 35
}

variable "backup_report_name" {
  type    = string
  default = "TestBackupReport"
}

variable "report_bucket_name" {
  type    = string
  default = null
}

# Vault lock config
variable "changeable_for_days" {
  type    = number
  default = 3
}

variable "max_retention_days" {
  type    = number
  default = 365
}

variable "min_retention_days" {
  type    = number
  default = 7
}

variable "need_lock" {
  type    = bool
  default = false
}