resource "aws_iam_policy" "api_gw_policy" {
  name        = var.api_gw_policy_name
  path        = "/"
  description = "Policy to enable logging to AWS Cloudwatch"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    Name    = var.api_gw_policy_name
    Billing = var.api_gw_policy_name
  }
}

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

resource "aws_iam_role_policy_attachment" "api_gw_role_policy" {
  role       = aws_iam_role.api_gw_role.name
  policy_arn = aws_iam_policy.api_gw_policy.arn
}