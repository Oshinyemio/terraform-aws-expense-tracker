########################
# 📤 API Module Outputs
########################

# 🔗 Root REST API ID (used in other modules)
output "rest_api_id" {
  value = aws_api_gateway_rest_api.expense_api.id
}

# 🏷️ Deployed Stage Name (usually "prod")
output "stage_name" {
  value = aws_api_gateway_stage.prod.stage_name
}

# 🌐 Full Invoke URL for API Gateway
output "api_invoke_url" {
  description = "Invoke URL for the API Gateway"
  value = format(
    "https://%s.execute-api.%s.amazonaws.com/%s",
    aws_api_gateway_rest_api.expense_api.id,
    var.aws_region,
    var.stage_name
  )
}
