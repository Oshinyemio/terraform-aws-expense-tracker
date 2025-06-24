########################
# 🔐 Cognito User Pool
########################

resource "aws_cognito_user_pool" "this" {
  name = "${var.project_name}-user-pool"

  username_configuration {
    case_sensitive = false
  }

  auto_verified_attributes = ["email"]

  schema {
    name               = "email"
    attribute_data_type = "String"
    required           = true
    mutable            = true
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }
}

########################
# 🧩 User Pool Client
########################

resource "aws_cognito_user_pool_client" "this" {
  name                         = "${var.user_pool_name}-client"
  user_pool_id                 = aws_cognito_user_pool.this.id
  generate_secret              = false
  explicit_auth_flows          = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
  prevent_user_existence_errors = "ENABLED"

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  supported_identity_providers     = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes             = ["email", "openid", "profile"]
  allowed_oauth_flows              = ["code"]

  depends_on = [aws_cognito_user_pool.this]
}

########################
# 🌐 User Pool Domain
########################

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.domain_prefix
  user_pool_id = aws_cognito_user_pool.this.id
}

########################
# 🆔 Cognito Identity Pool
########################

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name                = "${var.user_pool_name}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id              = aws_cognito_user_pool_client.this.id
    provider_name          = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }
}

########################
# 🎭 Identity Pool Roles Attachment
########################

resource "aws_cognito_identity_pool_roles_attachment" "this" {
  identity_pool_id = aws_cognito_identity_pool.this.id

  roles = {
    authenticated = var.authenticated_role_arn
  }
}
