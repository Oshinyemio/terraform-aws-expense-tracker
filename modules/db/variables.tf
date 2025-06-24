###############################
# 🗄️ DynamoDB Module Variables
###############################

# 🏷️ The name of the DynamoDB table
variable "table_name" {
  type        = string
  description = "The name of the DynamoDB table"
}

# 📛 Name of the project (used for tagging)
variable "project_name" {
  type        = string
  description = "Name of the project"
}
