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
# ERC Variables
################################################################################
variable "erc_repo_name" {
  type    = string
  default = "test_repository"
}

variable "tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "encryption_type" {
  type    = string
  default = "KMS"
}