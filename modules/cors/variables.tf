#################################
# 🔧 API Gateway CORS Module Variables
#################################

# 🆔 API Gateway REST API ID
variable "rest_api_id" {
  type        = string
  description = "ID of the API Gateway REST API"
}

# 🧱 API Gateway Resource ID
variable "resource_id" {
  type        = string
  description = "ID of the API Gateway resource to attach CORS settings"
}

# 📋 Allowed HTTP Methods for CORS
variable "allowed_methods" {
  type        = list(string)
  description = "List of HTTP methods allowed for CORS (e.g., [\"OPTIONS\", \"GET\", \"POST\"])"
  default     = ["POST"]
}
