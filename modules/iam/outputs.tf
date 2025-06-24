##########################
# 🏷️ IAM Role Outputs
##########################

# 🧩 Lambda Execution Role ARN
output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

# 🔐 Cognito Authenticated Role ARN
output "cognito_authenticated_role_arn" {
  value = aws_iam_role.cognito_authenticated.arn
}
