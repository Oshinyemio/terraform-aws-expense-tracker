##############################
# 📤 Get Expense Lambda Outputs
##############################

output "get_expense_lambda_name" {
  description = "Name of the Get Expense Lambda function"
  value       = aws_lambda_function.get_expense.function_name
}

output "get_expense_lambda_arn" {
  description = "ARN of the Get Expense Lambda function"
  value       = aws_lambda_function.get_expense.arn
}
