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

################################################################################
# CloudWatch Variables
################################################################################
variable "log_group_name" {
  type    = string
  default = "/aws/lambda/Test_Lambda_Log_Group"
}

################################################################################
# Lambda Variables
################################################################################
variable "zip_source_path" {
  type    = string
  default = "data/lambda_function.py"
}

variable "zip_output_path" {
  type    = string
  default = "data/code.zip"
}

variable "function_name" {
  type    = string
  default = "Test_Lambda"
}

variable "handler" {
  type    = string
  default = "lambda_function.lambda_handler"
}

variable "runtime" {
  type    = string
  default = "python3.9"
}

variable "timeout" {
  type    = number
  default = 3
}

variable "memory_size" {
  type    = number
  default = 128
}
