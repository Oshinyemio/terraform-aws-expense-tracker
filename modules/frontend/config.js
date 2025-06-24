// 📁 Global configuration injected at deploy time by Terraform

window.config = {
  apiBase: "https://edfprvvi60.execute-api.us-east-1.amazonaws.com/prod",         // 🌐 Base URL for API Gateway (e.g., https://abc123.execute-api...)
  userPoolId: "us-east-1_DZ84G8jdO",  // 🔐 Cognito User Pool ID
  clientId: "uhjol1f590ctkpedgi3i8nkho"        // 🧾 Cognito App Client ID (no secret)
};
