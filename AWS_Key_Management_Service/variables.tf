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
# KMS  Variables
################################################################################

variable "key_desc" {
  type    = string
  default = "Customer Managed Key"
}

variable "key_usage" {
  type    = string
  default = "ENCRYPT_DECRYPT"
}

variable "master_key_spec" {
  type    = string
  default = "SYMMETRIC_DEFAULT"
}

variable "deletion_window" {
  type    = number
  default = 7
}

variable "key_enabled" {
  type    = bool
  default = true
}

variable "key_rotation" {
  type    = bool
  default = true
}

variable "multi_region" {
  type    = bool
  default = false
}

variable "key_tag" {
  type    = string
  default = "TestKey"
}