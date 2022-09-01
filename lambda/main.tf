data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_cloudwatch_log_group" "log" {
  name              = var.log_group_name
  retention_in_days = 3
  tags = {
    Name    = var.log_group_name
    Billing = var.log_group_name
  }
}