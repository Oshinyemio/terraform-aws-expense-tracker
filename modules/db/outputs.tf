###############################
# 🗄️ DynamoDB Module Outputs
###############################

# 🏷️ Name of the DynamoDB expense table
output "table_name" {
  value = aws_dynamodb_table.expense_table.name
}

# 🛡️ ARN of the DynamoDB expense table
output "table_arn" {
  value = aws_dynamodb_table.expense_table.arn
}
