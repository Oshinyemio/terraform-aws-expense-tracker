#################################
# 🌐 AWS Region & Stage Variables
#################################

variable "aws_region" {
  description = "AWS region (e.g. us-east-1)"
  type        = string
  default     = "us-east-1"   # ← or set your preferred region
}

variable "stage_name" {
  description = "API Gateway stage name (e.g. prod, dev)"
  type        = string
  default     = "prod"        # ← you can set a sensible default here
}
