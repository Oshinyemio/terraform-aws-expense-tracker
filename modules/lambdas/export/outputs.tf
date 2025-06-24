###############################
# 📤 Export Expense Lambda Outputs
###############################

# 🏷️ Export Expense Lambda function name
output "export_expense_lambda_name" {
  value = aws_lambda_function.export_expense.function_name
}

# 🔗 Export Expense Lambda function ARN
output "export_expense_lambda_arn" {
  value = aws_lambda_function.export_expense.arn
}
