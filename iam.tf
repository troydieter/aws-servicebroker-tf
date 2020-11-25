data "aws_caller_identity" "current" {}

data "template_file" "awsservicebrokerpolicy" {
   template = file("AwsServiceBrokerPolicy.json")

   vars = {
     aws_region = var.aws_region
     aws_account = data.aws_caller_identity.current.account_id
     aws_dynamodb_table = aws_dynamodb_table.brokertable.id
   }
}

data "template_file" "awsservicebrokerprovisioningpolicy" {
   template = file("AwsServiceBrokerProvisioningPolicy.json")

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
  tags = {
    Use = "Service Broker"
  }
}

resource "aws_iam_group" "serv-broker-group" {
  name = "serv-broker-group-${random_id.ddb-rand.hex}"
}

resource "aws_iam_group_membership" "serv-broker-group-membership" {
  name = "serv-broker-group-membership-${random_id.ddb-rand.hex}"
  group = aws_iam_group.serv-broker-group.name
  users = [aws_iam_user.serv-broker-user.name]
}

resource "aws_iam_policy" "awsservicebroker_policy" {
  name        = "awsservicebroker_policy-${random_id.ddb-rand.hex}"
  description = "Policy that is to be attached to the AWS Service Broker User"
  policy      = data.template_file.awsservicebrokerpolicy.rendered
}

resource "aws_iam_policy" "awsservicebrokerprovisioningpolicy_policy" {
  name        = "awsservicebrokerprovisioningpolicy_policy-${random_id.ddb-rand.hex}"
  description = "Policy that is to be attached to the AWS Service Broker Provisioning"
  policy      = data.template_file.awsservicebrokerprovisioningpolicy.rendered
}

resource "aws_iam_group_policy_attachment" "awsservicebroker_policy-attach" {
  group = aws_iam_group.serv-broker-group.name
  policy_arn = aws_iam_policy.awsservicebroker_policy.arn
}

resource "aws_iam_group_policy_attachment" "awsservicebrokerprovisioningpolicy_policy-attach" {
  group = aws_iam_group.serv-broker-group.name
  policy_arn = aws_iam_policy.awsservicebrokerprovisioningpolicy_policy.arn
}

output "serv-broker" {
  value = aws_iam_user.serv-broker-user.name
  description = "The IAM username needed for use with the AWS Service Broker"
}