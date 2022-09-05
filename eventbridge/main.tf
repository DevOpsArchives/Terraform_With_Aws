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

# resource "aws_cloudwatch_event_bus" "bus" {
#   name = var.event_bus_name
#   tags = {
#     Name    = var.event_bus_name
#     Billing = var.event_bus_name
#   }
# }

# resource "aws_cloudwatch_event_archive" "archive" {
#   name             = var.event_archive_name
#   event_source_arn = aws_cloudwatch_event_bus.bus.arn
#   description      = "All events are stored here"
#   retention_days   = 7
# }

resource "aws_cloudwatch_event_rule" "rule" {
  name           = var.event_rule_name
  description    = "Scheduled rate based evendbridge rule"

  schedule_expression = "rate(1 minute)"
  is_enabled          = true

  tags = {
    Name    = var.event_rule_name
    Billing = var.event_rule_name
  }
}

resource "aws_cloudwatch_event_target" "target" {
  rule           = aws_cloudwatch_event_rule.rule.name
  arn            = module.lambda.function_arn
  retry_policy {
    maximum_retry_attempts = 2
    maximum_event_age_in_seconds = 60
  }
}
