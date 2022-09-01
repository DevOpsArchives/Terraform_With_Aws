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
# IAM Variables
################################################################################
variable "role_name" {
  type    = string
  default = "Test_Lambda_Role"
}

variable "policy_name" {
  type    = string
  default = "Test_Lambda_Policy"
}
