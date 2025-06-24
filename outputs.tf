#################################
# 🗄️ DynamoDB Outputs
#################################

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}

#################################
# 🔐 IAM & Lambda Outputs
#################################

output "lambda_role_arn" {
  description = "The ARN of the IAM role for Lambda execution"
  value       = module.iam.lambda_role_arn
}

output "lambda_add_expense_name" {
  value = module.lambda_add_expense.add_expense_lambda_name
}

output "lambda_add_expense_arn" {
  value = module.lambda_add_expense.add_expense_lambda_arn
}

#################################
# 📦 S3 Data Bucket Outputs
#################################

output "expense_data_bucket_name" {
  value = module.s3_data.bucket_name
}

output "expense_data_bucket_arn" {
  value = module.s3_data.bucket_arn
}

#################################
# 🌐 API Gateway Outputs
#################################

output "api_invoke_url" {
  description = "API Gateway base invoke URL"
  value = format(
    "https://%s.execute-api.%s.amazonaws.com/%s",
    module.api.rest_api_id,
    var.aws_region,
    module.api.stage_name
  )
}

#################################
# 🔐 Cognito Outputs
#################################

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_user_pool_arn" {
  value = module.cognito.user_pool_arn
}

output "cognito_user_pool_client_id" {
  value = module.cognito.user_pool_client_id
}

output "cognito_hosted_ui_url" {
  value = module.cognito.cognito_domain_url
}

output "cognito_identity_pool_id" {
  value = module.cognito.identity_pool_id
}

output "cognito_authenticated_role_arn" {
  value = module.iam.cognito_authenticated_role_arn
}

#################################
# 🏠 Frontend Hosting Outputs
#################################

output "frontend_bucket_name" {
  description = "S3 bucket for static frontend website hosting"
  value       = module.frontend.frontend_bucket_name
}

output "frontend_bucket_arn" {
  description = "ARN of the frontend hosting bucket"
  value       = module.frontend.frontend_bucket_arn
}

output "frontend_cloudfront_url" {
  description = "Public CloudFront URL to access the frontend"
  value       = "https://${module.frontend.cloudfront_url}"
}

#################################
# 🚪 URLs for Login & Tracker Page
#################################

output "cognito_full_login_url" {
  value = format(
    "%s/login?client_id=%s&response_type=code&scope=email+openid+profile&redirect_uri=%s",
    module.cognito.cognito_domain_url,
    module.cognito.user_pool_client_id,
    urlencode("http://localhost:3000/login.html")
  )
}

output "cognito_login_redirect_to_tracker" {
  description = "Full Cognito login URL that redirects to tracker page after auth"
  value = format(
    "%s/login?client_id=%s&response_type=token&scope=email+openid+profile&redirect_uri=%s",
    module.cognito.cognito_domain_url,
    module.cognito.user_pool_client_id,
    urlencode(format("https://%s/tracker.html", module.frontend.cloudfront_url))
  )
}

output "tracker_page_url" {
  description = "Direct URL to access the tracker.html page (after login)"
  value       = format("https://%s/tracker.html", module.frontend.cloudfront_url)
}
