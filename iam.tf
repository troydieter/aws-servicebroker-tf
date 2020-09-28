data "aws_caller_identity" "current" {}

resource "random_id" "iam-rand" {
  byte_length = 6
}

resource "aws_iam_user" "pcf_serv-broker-user" {
  name = "pcf_serv-broker-user-${random_id.ddb-rand.hex}"
}

resource "aws_iam_policy" "pcf_serv-broker_policy" {
  name        = "pcf_serv-broker_policy"
  description = "Policy that is to be attached to the PCF Service Broker User"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "SsmForSecretBindings",
        "Action": "ssm:PutParameter",
        "Resource": "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/asb-*",
        "Effect": "Allow"
      },
      {
        "Sid": "AllowCfnToGetTemplates",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::awsservicebroker/templates/*",
        "Effect": "Allow"
      },
      {
         "Sid": "CloudFormation",
         "Action": [
            "cloudformation:CreateStack",
            "cloudformation:DeleteStack",
            "cloudformation:DescribeStacks",
            "cloudformation:DescribeStackEvents",
            "cloudformation:UpdateStack",
            "cloudformation:CancelUpdateStack"
         ],
         "Resource": [
            "arn:aws:cloudformation:${var.aws_region}:${data.aws_caller_identity.current.account_id}:stack/aws-service-broker-*/*"
         ],
         "Effect": "Allow"
      },
     {
        "Sid": "ServiceClassPermissions",
        "Action": [
           "athena:*",
           "dynamodb:*",
           "kms:*",
           "elasticache:*",
           "elasticmapreduce:*",
           "kinesis:*",
           "rds:*",
           "redshift:*",
           "route53:*",
           "s3:*",
           "sns:*",
           "sqs:*",
           "ec2:*",
           "iam:*",
           "lambda:*"
        ],
        "Resource": [
           "*"
        ],
        "Effect": "Allow"
     },
     {
        "Action": [
           "s3:GetObject",
           "s3:ListBucket"
        ],
        "Resource": [
           "arn:aws:s3:::awsservicebroker/templates/*",
           "arn:aws:s3:::awsservicebroker"
        ],
        "Effect": "Allow"
      },
      {
        "Action": [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem"
        ],
        "Resource": "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/{aws_dynamodb_table.brokertable.id}",
        "Effect": "Allow"
      },
      {
        "Action": [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ],
        "Resource": [
            "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/asb-*",
            "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/Asb*"
        ],
        "Effect": "Allow"
      }
   ]
}
EOF
}

resource "aws_iam_policy_attachment" "pcf_serv-broker_policy" {
  name       = "pcf_serv-broker_policy-attach"
  users      = [aws_iam_user.pcf_serv-broker-user.name]
  policy_arn = aws_iam_policy.pcf_serv-broker_policy.arn
}

output "pcf_serv-broker" {
  value = aws_iam_user.pcf_serv-broker-user.arn
}