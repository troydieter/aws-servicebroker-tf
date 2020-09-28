resource "random_id" "ddb-rand" {
  byte_length = 6
}

resource "aws_dynamodb_table" "brokertable" {
  name           = "awssb-${random_id.ddb-rand.hex}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"
  range_key      = "userid"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "userid"
    type = "S"
  }

  attribute {
    name = "type"
    type = "S"
  }

  global_secondary_index {
    name               = "type-userid-index-${random_id.ddb-rand.hex}"
    hash_key           = "type"
    range_key          = "userid"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["id", "userid", "type", "locked"]
  }

  tags = {
    environment = var.environment
  }
}

output "brokertable" {
  value = aws_dynamodb_table.brokertable.arn
}