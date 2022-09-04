resource "aws_iam_role" "api_gw_role" {
  name        = var.api_gw_role_name
  description = "Allows API Gateway to push logs to CloudWatch Logs."

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "apigateway.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = var.api_gw_role_name
    Billing = var.api_gw_role_name
  }
}

# https://aws.amazon.com/premiumsupport/knowledge-center/api-gateway-cloudwatch-logs/
# Use the above link to only make the policy if data source gives error
data "aws_iam_policy" "api_gw_cloudwatch" {
  name = var.aws_managed_cloudwatch_policy_name
}

resource "aws_iam_role_policy_attachment" "api_gw_role_policy" {
  role       = aws_iam_role.api_gw_role.name
  policy_arn = data.aws_iam_policy.api_gw_cloudwatch.arn
}
