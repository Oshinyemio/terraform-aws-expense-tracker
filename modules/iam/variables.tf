#################################
# 🔧 IAM Module Variables
#################################

# 🏷️ Project name prefix (used for naming roles and policies)
variable "project_name" {
  type = string
}

# 📋 ARN of the DynamoDB table (for Lambda permissions)
variable "dynamodb_table_arn" {
  type = string
}

# 📦 ARN of the S3 bucket (for Lambda permissions)
variable "s3_bucket_arn" {
  type = string
}

# 🔐 Cognito Identity Pool ID (used in IAM role trust policy)
variable "identity_pool_id" {
  description = "Cognito Identity Pool ID (for role trust)"
  type        = string
}
