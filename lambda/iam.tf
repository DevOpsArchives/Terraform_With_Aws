resource "aws_iam_role" "Role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
  tags = {
    "Name" = var.role_name,
    "Billing" : var.role_name
  }
}

resource "aws_iam_policy" "lambda_logging_policy" {
  name        = var.policy_name
  path        = "/"
  description = "Default Policy for Lambda"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "logs:CreateLogGroup",
        "Resource" : "arn:aws:logs:${var.region}:${local.account_id}:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "${aws_cloudwatch_log_group.log.arn}:*"
        ]
      },
    ]
  })

  depends_on = [
    aws_cloudwatch_log_group.log
  ]

}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.Role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}
