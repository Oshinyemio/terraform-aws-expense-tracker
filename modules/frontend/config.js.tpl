// 📁 Global configuration injected at deploy time by Terraform

window.config = {
  apiBase: "${api_base}",         // 🌐 Base URL for API Gateway (e.g., https://abc123.execute-api...)
  userPoolId: "${user_pool_id}",  // 🔐 Cognito User Pool ID
  clientId: "${client_id}"        // 🧾 Cognito App Client ID (no secret)
};
