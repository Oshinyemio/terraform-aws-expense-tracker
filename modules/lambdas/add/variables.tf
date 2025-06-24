#################################
# 🐍 Add Expense Lambda Variables
#################################

# 🏷️ Project-wide name prefix (used for resource naming)
variable "project_name" {
  type        = string
  description = "Project name prefix"
}

# 🐟 Lambda function name (e.g., myet-add-expense)
variable "lambda_name" {
  type        = string
  description = "Name of the Add Expense Lambda function"
}

# 🔐 ARN of the IAM role assumed by the Lambda function
variable "lambda_role_arn" {
  type        = string
  description = "IAM Role ARN for Lambda execution"
}

# 📦 Local path to the zipped Lambda deployment package
variable "lambda_zip_path" {
  type        = string
  description = "File path to Lambda deployment zip"
}

# 🗃️ Name of the DynamoDB table used by the Lambda
variable "dynamodb_table" {
  type        = string
  description = "DynamoDB table name"
}

# 🪣 Name of the S3 bucket for storing expense data
variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for expense data storage"
}
