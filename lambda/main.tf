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
