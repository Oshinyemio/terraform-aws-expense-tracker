##########################
# 🐍 Lambda: Add Expense
##########################

resource "aws_lambda_function" "add_expense" {
  function_name = "${var.project_name}-add-expense"
  runtime       = "python3.9"
  handler       = "add_expense.lambda_handler"

  role = var.lambda_role_arn

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      DYNAMODB_TABLE      = var.dynamodb_table
      EXPENSE_DATA_BUCKET = var.s3_bucket_name
    }
  }

  tags = {
    Project = var.project_name
  }
}
