#################################
# 🔧 API Gateway Module Variables
#################################

# 🏷️ Project-wide name prefix (e.g., "myET")
variable "project_name" {
  type        = string
  description = "Name of the project (used for naming API resources)"
}

# 📍 Region and stage
variable "aws_region" {
  type        = string
  description = "AWS region (e.g., us-east-1)"
  default     = "us-east-1"
}

variable "stage_name" {
  type        = string
  description = "API Gateway stage name (e.g., prod, dev)"
  default     = "prod"
}

# 🔐 Cognito for securing API
variable "cognito_user_pool_arn" {
  type        = string
  description = "ARN of the Cognito User Pool used for API authorization"
}

# ⚙️ Lambda: Add Expense
variable "add_expense_lambda_function_name" {
  type        = string
  description = "Name of the Add Expense Lambda function"
}

variable "add_expense_lambda_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Add Expense Lambda function"
}

# ⚙️ Lambda: Get Expense
variable "get_expense_lambda_function_name" {
  type        = string
  description = "Name of the Get Expense Lambda function"
}

variable "get_expense_lambda_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Get Expense Lambda function"
}

# ⚙️ Lambda: Export Expense
variable "export_expense_lambda_function_name" {
  type        = string
  description = "Name of the Export Expense Lambda function"
}

variable "export_expense_lambda_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Export Expense Lambda function"
}
