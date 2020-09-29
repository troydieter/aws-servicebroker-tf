data "aws_caller_identity" "current" {}

 data "template_file" "serv-broker-policy" {
   template = file("serv-broker-policy.json")

   vars = {
     aws_region = var.aws_region
     aws_account = data.aws_caller_identity.current.account_id
     aws_dynamodb_table = aws_dynamodb_table.brokertable.id
   }
 }

resource "random_id" "iam-rand" {
  byte_length = 6
}

resource "aws_iam_user" "serv-broker-user" {
  name = "serv-broker-user-${random_id.ddb-rand.hex}"
}

resource "aws_iam_policy" "serv-broker_policy" {
  name        = "serv-broker_policy"
  description = "Policy that is to be attached to the PCF Service Broker User"
  policy      = data.template_file.serv-broker-policy.rendered
}

resource "aws_iam_policy_attachment" "serv-broker_policy" {
  name       = "serv-broker_policy-attach"
  users      = [aws_iam_user.serv-broker-user.name]
  policy_arn = aws_iam_policy.serv-broker_policy.arn
}

output "serv-broker" {
  value = aws_iam_user.serv-broker-user.name
  description = "The IAM username needed for use with the AWS Service Broker"
}