##############################
# 🐍 Get Expense Lambda Function
##############################

resource "aws_lambda_function" "get_expense" {
  function_name    = "${var.project_name}-get-expense"
  runtime          = "python3.12"
  handler          = "get_expense.lambda_handler"
  role             = var.lambda_role_arn
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      DYNAMODB_TABLE         = var.dynamodb_table
      DYNAMODB_PARTITION_KEY = "userId"
    }
  }

  tags = {
    Project = var.project_name
  }
}
