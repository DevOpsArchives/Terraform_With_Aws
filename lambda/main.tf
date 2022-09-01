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

data "archive_file" "code_archive" {
  type        = "zip"
  source_file = var.zip_source_path
  output_path = var.zip_output_path
}

resource "null_resource" "null" {
  triggers = {
    output_path = "${var.zip_output_path}"
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "Del ${self.triggers.output_path}"
    interpreter = ["PowerShell"]
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = var.zip_output_path
  function_name = var.function_name
  handler       = var.handler

  role = aws_iam_role.Role.arn

  runtime      = var.runtime
  timeout      = var.timeout
  memory_size  = var.memory_size
  package_type = "Zip"

  description = "This is a test lambda"

  depends_on = [
    data.archive_file.code_archive,
    aws_cloudwatch_log_group.log,
    aws_iam_role_policy_attachment.role_policy_attachment,
  ]
  environment {
    variables = {
      from = "Matrix"
    }
  }
  tags = {
    Name    = var.function_name
    Billing = var.function_name
  }
}

resource "aws_lambda_invocation" "invocation" {
  function_name = aws_lambda_function.lambda.function_name

  input = jsonencode({})
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }

  depends_on = [
    aws_lambda_function.lambda
  ]
}

