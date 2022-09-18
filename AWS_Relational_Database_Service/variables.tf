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
# RDS Variables
################################################################################
variable "db_identifier_name" {
  type    = string
  default = "test-database"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.28"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "admin123"
}

variable "param_grp_name" {
  type    = string
  default = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "allow_major_version_upgrade" {
  type    = bool
  default = true
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Flag to instruct the service to apply the change immediately"
}

variable "backup_retention_period" {
  type    = number
  default = 20
}

variable "backup_window" {
  type    = string
  default = "09:25-10:25"
}

variable "delete_automated_backups" {
  type    = bool
  default = true
}

variable "maintenance_window" {
  type    = string
  default = "Mon:00:00-Mon:00:30"
}

variable "cloudwatch_logs_exports_list" {
  type    = list(string)
  default = ["audit", "error", "general", "slowquery"]
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "monitoring_interval" {
  type    = number
  default = 0
}

variable "kms_arn" {
  type    = string
  default = null
}

variable "network_type" {
  type    = string
  default = "IPV4"
}

variable "port" {
  type    = number
  default = 3606
}

variable "publicly_accessible" {
  type    = bool
  default = true
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "is_storage_encrypted" {
  type    = bool
  default = true
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 1000
}

variable "db_snapshot_identifier" {
  type    = string
  default = "test-database-identifier"
}