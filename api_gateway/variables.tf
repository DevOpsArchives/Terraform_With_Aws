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