# Make Lambda for Integration with API Gateway
module "lambda" {
  source = "../lambda"
}

data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
}

resource "aws_api_gateway_rest_api" "api" {
  name        = var.rest_api_name
  description = "This is a test REST API made with terraform"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = {
    Name    = var.rest_api_name
    Billing = var.rest_api_name
  }

  depends_on = [
    module.lambda
  ]

}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.resource_path
}

resource "aws_api_gateway_method" "method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.resource.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = var.is_api_key_required

  depends_on = [
    aws_api_gateway_api_key.api_key
  ]

}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "method_resp" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"

  depends_on = [
    aws_api_gateway_method.method
  ]
}

resource "aws_api_gateway_integration_response" "integration_resp" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.method_resp.status_code

  depends_on = [
    aws_api_gateway_integration.integration
  ]
}

resource "aws_lambda_permission" "apigw_lambda_perm" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${local.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"

  depends_on = [
    aws_api_gateway_rest_api.api
  ]
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  description = "Deployment of AWS API Gateway HTTP Rest API"

  depends_on = [
    aws_api_gateway_method.method,
    aws_api_gateway_integration.integration
  ]

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.api_gw_stage_name
}

# This below block might cause problem for those who already have the global account settings enabled
resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = aws_iam_role.api_gw_role.arn
}

resource "aws_api_gateway_method_settings" "m_setting" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled        = true
    logging_level          = "INFO"
    throttling_burst_limit = var.burst_limit
    throttling_rate_limit  = var.rate_limit
  }

  depends_on = [
    aws_api_gateway_deployment.deployment,
    aws_api_gateway_account.account
  ]
}

resource "aws_api_gateway_gateway_response" "gw_resp_unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = jsonencode({
      "message" : "Please use the right api key"
    })
  }
}

resource "aws_api_gateway_api_key" "api_key" {
  name        = var.api_key_name
  description = "API Key for API Gateway"

  provisioner "local-exec" {
    command = "echo ${aws_api_gateway_api_key.api_key.value} > api_key.txt"
  }
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name        = "usage_${var.rest_api_name}"
  description = "Usage plan for API Gateway"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.stage.stage_name
  }

  throttle_settings {
    burst_limit = var.burst_limit
    rate_limit  = var.rate_limit
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = var.usage_plan_key_type
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}