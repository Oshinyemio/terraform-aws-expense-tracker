#################################
# 🔧 Cognito Auth Module Variables
#################################

# 🌍 AWS Region
variable "aws_region" {
  type        = string
  description = "AWS region (e.g., us-east-1)"
}

# 🏷️ Cognito User Pool Name
variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool"
}

# 🔑 IAM Role ARN for Authenticated Users
variable "authenticated_role_arn" {
  type        = string
  description = "IAM role ARN assigned to authenticated Cognito users"
}

# 🔗 List of Allowed Callback URLs after Login
variable "callback_urls" {
  type        = list(string)
  description = "List of allowed callback URLs for OAuth2 login flows"
}

# 🔗 List of Allowed Logout URLs
variable "logout_urls" {
  type        = list(string)
  description = "List of allowed logout URLs for OAuth2 flows"
}

# 🌐 Domain Prefix for Cognito Hosted UI
variable "domain_prefix" {
  type        = string
  description = "Prefix for the Cognito Hosted UI domain (e.g., 'myet-app' results in 'myet-app.auth.us-east-1.amazoncognito.com')"
}

# 📛 Project Name (for resource naming)
variable "project_name" {
  type        = string
  description = "Project name prefix used for resource naming"
  default     = "myet"
}
