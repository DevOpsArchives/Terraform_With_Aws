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
