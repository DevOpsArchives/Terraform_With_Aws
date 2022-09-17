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
# API Gateway Variables
################################################################################
variable "rest_api_name" {
  type        = string
  default     = "TestRestAPI"
  description = "Name for AWS APIGateway RestAPI made with terraform"
}

variable "api_gw_stage_name" {
  type    = string
  default = "dev"
}

variable "resource_path" {
  type    = string
  default = "hello"
}

variable "usage_plan_key_type" {
  default = "API_KEY"
  type    = string
}

variable "burst_limit" {
  type    = number
  default = 500
}

variable "rate_limit" {
  type    = number
  default = 1000
}

variable "api_key_name" {
  type    = string
  default = "TestAPIKey"
}

variable "is_api_key_required" {
  type    = bool
  default = true
}
################################################################################
# Identity and Access Management Variables
################################################################################
variable "api_gw_role_name" {
  type    = string
  default = "APIGatewayToCloudWatch"
}

variable "aws_managed_cloudwatch_policy_name" {
  type    = string
  default = "AmazonAPIGatewayPushToCloudWatchLogs"
}