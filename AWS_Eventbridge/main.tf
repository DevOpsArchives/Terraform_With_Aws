data "aws_caller_identity" "caller" {}

locals {
  account_id = data.aws_caller_identity.caller.account_id
}

module "lambda" {
  source = "../lambda"
}

resource "aws_lambda_permission" "lambda_event_permission" {
  statement_id  = "InvokeLambdaFunction"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "events.amazonaws.com"

  # More: https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-use-resource-based.html
  source_arn = "arn:aws:events:${var.region}:${local.account_id}:ruke/${var.event_rule_name}"

  depends_on = [
    module.lambda
  ]
}

data "aws_cloudwatch_event_bus" "bus_ds" {
  name = "default"
}

resource "aws_cloudwatch_event_archive" "archive" {
  name             = var.event_archive_name
  event_source_arn = data.aws_cloudwatch_event_bus.bus_ds.arn
  description      = "All events are stored here"
  retention_days   = var.archive_retention

  depends_on = [
    data.aws_cloudwatch_event_bus.bus_ds
  ]
}

resource "aws_cloudwatch_event_rule" "rule" {
  name        = var.event_rule_name
  description = "Scheduled rate based evendbridge rule"

  schedule_expression = var.event_expression
  is_enabled          = true

  tags = {
    Name    = var.event_rule_name
    Billing = var.event_rule_name
  }
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.rule.name
  arn  = module.lambda.function_arn
  retry_policy {
    maximum_retry_attempts       = var.retry_policy.max_retry_attempts
    maximum_event_age_in_seconds = var.retry_policy.max_event_age_in_seconds
  }
}
