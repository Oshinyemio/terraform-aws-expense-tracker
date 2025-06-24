#################################
# 🌐 AWS Provider Configuration
#################################

provider "aws" {
  region = var.aws_region
}

#################################
# 📦 DynamoDB Module
#################################

module "dynamodb" {
  source       = "./modules/db"
  table_name   = "ET-Expenses"
  project_name = "ET"
}

#################################
# 🔐 IAM Module
#################################

module "iam" {
  source             = "./modules/iam"
  project_name       = "ET"
  dynamodb_table_arn = module.dynamodb.table_arn
  s3_bucket_arn      = module.s3_data.bucket_arn
  identity_pool_id   = module.cognito.identity_pool_id
}

#################################
# 🗄️ S3 Data Bucket Module
#################################

module "s3_data" {
  source       = "./modules/s3_data"
  project_name = "ET"
}

#################################
# 🐍 Lambda Modules
#################################

module "lambda_add_expense" {
  source           = "./modules/lambdas/add"
  project_name     = "ET"
  lambda_name      = "add-expense"
  lambda_role_arn  = module.iam.lambda_role_arn
  lambda_zip_path  = "${path.root}/build/lambda_zips/add.zip"
  dynamodb_table   = module.dynamodb.table_name
  s3_bucket_name   = module.s3_data.bucket_name
}

module "lambda_get_expense" {
  source           = "./modules/lambdas/get"
  project_name     = "ET"
  lambda_role_arn  = module.iam.lambda_role_arn
  lambda_zip_path  = "${path.root}/build/lambda_zips/get.zip"
  dynamodb_table   = module.dynamodb.table_name
}

module "lambda_export_expense" {
  source           = "./modules/lambdas/export"
  project_name     = "ET"
  lambda_role_arn  = module.iam.lambda_role_arn
  lambda_zip_path  = "${path.root}/build/lambda_zips/export.zip"
  dynamodb_table   = module.dynamodb.table_name
  s3_bucket_name   = module.s3_data.bucket_name 
}

#################################
# 🚪 API Gateway Module
#################################

module "api" {
  source = "./modules/api"

  project_name = "ET"
  aws_region   = var.aws_region
  stage_name   = var.stage_name

  add_expense_lambda_function_name    = module.lambda_add_expense.add_expense_lambda_name
  add_expense_lambda_invoke_arn       = module.lambda_add_expense.add_expense_lambda_arn

  get_expense_lambda_function_name    = module.lambda_get_expense.get_expense_lambda_name
  get_expense_lambda_invoke_arn       = module.lambda_get_expense.get_expense_lambda_arn

  export_expense_lambda_function_name = module.lambda_export_expense.export_expense_lambda_name
  export_expense_lambda_invoke_arn    = module.lambda_export_expense.export_expense_lambda_arn

  cognito_user_pool_arn = module.cognito.user_pool_arn
}

#################################
# 🧑‍💻 Cognito Auth Module
#################################

module "cognito" {
  source               = "./modules/auth"
  user_pool_name       = "myET-user-pool"
  aws_region           = var.aws_region
  domain_prefix        = "myet-auth"
  callback_urls        = ["http://localhost:3000/login.html"]
  logout_urls          = ["http://localhost:3000/logout"]
  authenticated_role_arn = module.iam.cognito_authenticated_role_arn
}

#################################
# 🏠 Frontend Hosting Module
#################################

module "frontend" {
  source       = "./modules/frontend"
  api_base     = module.api.api_invoke_url
  user_pool_id = module.cognito.user_pool_id
  client_id    = module.cognito.user_pool_client_id
}
