###############################
# 🔐 IAM Role for Cognito Authenticated Users
###############################

resource "aws_iam_role" "cognito_authenticated" {
  name = "myet_cognito_authenticated_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "cognito-identity.amazonaws.com:aud" = var.identity_pool_id
          }
          "ForAnyValue:StringLike" = {
            "cognito-identity.amazonaws.com:amr" = "authenticated"
          }
        }
      }
    ]
  })
}

###############################
# 🔑 IAM Policy: API Gateway Invoke Permission
###############################

resource "aws_iam_role_policy" "cognito_api_access" {
  name = "myet_cognito_api_access"
  role = aws_iam_role.cognito_authenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "execute-api:Invoke"
        ]
        Resource = "*"
      }
    ]
  })
}
