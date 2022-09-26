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
# VPC  Variables
################################################################################
variable "vpc_name" {
  type = string
  default = "TestVPC"
  description = "Name of the VPC to be used"
}

variable "cird_range" {
  type = string
  default = "10.0.0.0/24"
  description = "CIRD range for the VPC"
}

variable "vpc_mode" {
  type = string
  default = "vpc_baisc"
  description = "The Type of vpc we want to use vpc_baisc/vpc_ipam"
}