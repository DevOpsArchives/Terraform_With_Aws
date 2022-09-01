output "lambda_invocation_result" {
  value = jsondecode(aws_lambda_invocation.invocation.result)
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_url.function_url
}
