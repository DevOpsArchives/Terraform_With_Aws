output "lambda_invocation_result" {
  value = jsondecode(aws_lambda_invocation.invocation.result)
}
