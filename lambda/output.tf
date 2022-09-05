output "lambda_invocation_result" {
  value = jsondecode(aws_lambda_invocation.invocation.result)
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_url.function_url
}

output "invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}

output "function_arn" {
  value = aws_lambda_function.lambda.arn
}

output "function_name" {
  value = aws_lambda_function.lambda.function_name
}