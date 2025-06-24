########################
# 🆔 Cognito User Pool Outputs
########################

# 🔑 User Pool ID
output "user_pool_id" {
  value = aws_cognito_user_pool.this.id
}

# 🛡️ User Pool ARN
output "user_pool_arn" {
  value = aws_cognito_user_pool.this.arn
}

# 🔐 User Pool Client ID
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.this.id
}

########################
# 🌍 Cognito Domain URL
########################

output "cognito_domain_url" {
  value = "https://${aws_cognito_user_pool_domain.this.domain}.auth.${var.aws_region}.amazoncognito.com"
}

########################
# 🆔 Identity Pool ID
########################

output "identity_pool_id" {
  value = aws_cognito_identity_pool.this.id
}
