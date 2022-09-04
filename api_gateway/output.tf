output "api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}${var.api_gw_stage_name}/${var.resource_path}"
}

output "api_key" {
  value     = aws_api_gateway_api_key.api_key.value
  sensitive = true
}