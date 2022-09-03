# Make Lambda for Integration with API Gateway
module "lambda" {
  source = "../lambda"
}

data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
}

resource "aws_api_gateway_rest_api" "this" {
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

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "this_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "200"

  depends_on = [
    aws_api_gateway_method.this
  ]
}

resource "aws_api_gateway_integration_response" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = aws_api_gateway_method_response.this_200.status_code

  depends_on = [
    aws_api_gateway_integration.this
  ]
}

resource "aws_lambda_permission" "apigw_lambda_perm" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${local.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"

  depends_on = [
    aws_api_gateway_rest_api.this
  ]
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  description = "Deployment of AWS API Gateway HTTP Rest API"

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.this.id,
      aws_api_gateway_method.this.id,
      aws_api_gateway_integration.this.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.api_gw_stage_name
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    # logging_level   = "INFO" # FIXME
  }
}

# resource "aws_cloudwatch_log_group" "this" {
#   name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.this.id}/${var.api_gw_stage_name}"
#   retention_in_days = 7

#   depends_on = [
#     aws_api_gateway_method_settings.this
#   ]
# }
