######################################
# 🚪 API Gateway: Expense Tracker API
######################################

resource "aws_api_gateway_rest_api" "expense_api" {
  name        = "${var.project_name}-api"
  description = "Unified API Gateway for Expense Tracker"
}

####################
# 📁 API Resources
####################

resource "aws_api_gateway_resource" "add_expense" {
  rest_api_id = aws_api_gateway_rest_api.expense_api.id
  parent_id   = aws_api_gateway_rest_api.expense_api.root_resource_id
  path_part   = "add-expense"
}

resource "aws_api_gateway_resource" "get_expense" {
  rest_api_id = aws_api_gateway_rest_api.expense_api.id
  parent_id   = aws_api_gateway_rest_api.expense_api.root_resource_id
  path_part   = "get-expense"
}

resource "aws_api_gateway_resource" "export_expense" {
  rest_api_id = aws_api_gateway_rest_api.expense_api.id
  parent_id   = aws_api_gateway_rest_api.expense_api.root_resource_id
  path_part   = "export-expense"
}

######################
# ⚙️  API Methods
######################

resource "aws_api_gateway_method" "add_expense_post" {
  rest_api_id   = aws_api_gateway_rest_api.expense_api.id
  resource_id   = aws_api_gateway_resource.add_expense.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "get_expense_get" {
  rest_api_id   = aws_api_gateway_rest_api.expense_api.id
  resource_id   = aws_api_gateway_resource.get_expense.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "export_expense_get" {
  rest_api_id   = aws_api_gateway_rest_api.expense_api.id
  resource_id   = aws_api_gateway_resource.export_expense.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

#####################################
# 🔌 Lambda Integrations
#####################################

resource "aws_api_gateway_integration" "add_expense_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.expense_api.id
  resource_id             = aws_api_gateway_resource.add_expense.id
  http_method             = aws_api_gateway_method.add_expense_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.add_expense_lambda_invoke_arn}/invocations"
}

resource "aws_api_gateway_integration" "get_expense_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.expense_api.id
  resource_id             = aws_api_gateway_resource.get_expense.id
  http_method             = aws_api_gateway_method.get_expense_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.get_expense_lambda_invoke_arn}/invocations"
}

resource "aws_api_gateway_integration" "export_expense_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.expense_api.id
  resource_id             = aws_api_gateway_resource.export_expense.id
  http_method             = aws_api_gateway_method.export_expense_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.export_expense_lambda_invoke_arn}/invocations"
}

#####################################
# 🛡️  Lambda Permissions
#####################################

resource "aws_lambda_permission" "allow_api_gateway_invoke_add_expense" {
  statement_id  = "AllowAPIGatewayInvokeAddExpense"
  action        = "lambda:InvokeFunction"
  function_name = var.add_expense_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.expense_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_api_gateway_invoke_get_expense" {
  statement_id  = "AllowAPIGatewayInvokeGetExpense"
  action        = "lambda:InvokeFunction"
  function_name = var.get_expense_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.expense_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_api_gateway_invoke_export" {
  statement_id  = "AllowAPIGatewayInvokeExport"
  action        = "lambda:InvokeFunction"
  function_name = var.export_expense_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.expense_api.execution_arn}/*/*"
}

###########################
# 🌐 CORS Support Modules
###########################

module "cors_add_expense" {
  source          = "../cors"
  rest_api_id     = aws_api_gateway_rest_api.expense_api.id
  resource_id     = aws_api_gateway_resource.add_expense.id
  allowed_methods = ["OPTIONS", "POST"]
}

module "cors_get_expense" {
  source          = "../cors"
  rest_api_id     = aws_api_gateway_rest_api.expense_api.id
  resource_id     = aws_api_gateway_resource.get_expense.id
  allowed_methods = ["OPTIONS", "GET"]
}

module "cors_export_expense" {
  source          = "../cors"
  rest_api_id     = aws_api_gateway_rest_api.expense_api.id
  resource_id     = aws_api_gateway_resource.export_expense.id
  allowed_methods = ["OPTIONS", "GET"]
}

###########################
# 🚀 Deployment & Staging
###########################

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.expense_api.id

  depends_on = [
    aws_api_gateway_integration.add_expense_lambda,
    aws_api_gateway_integration.get_expense_lambda,
    aws_api_gateway_integration.export_expense_lambda,
    module.cors_add_expense,
    module.cors_get_expense,
    module.cors_export_expense
  ]

  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.expense_api.id
  stage_name    = "prod"
}

###########################
# 👤 Cognito Authorizer
###########################

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name            = "cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.expense_api.id
  identity_source = "method.request.header.Authorization"
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [var.cognito_user_pool_arn]
}