#################################
# 🗄️ DynamoDB Expense Table Setup
#################################

# 🔹 DynamoDB table to store expenses with on-demand billing
resource "aws_dynamodb_table" "expense_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"  # Use on-demand capacity mode for cost efficiency

  # 🗝️ Primary key composed of userId (partition key) and timestamp (sort key)
  hash_key     = "userId"
  range_key    = "timestamp"

  # 🏷️ Attribute definitions
  attribute {
    name = "userId"
    type = "S"  # String type
  }

  attribute {
    name = "timestamp"
    type = "S"  # String type
  }

  # 🏷️ Tags to identify resource ownership
  tags = {
    Project = var.project_name
  }
}
