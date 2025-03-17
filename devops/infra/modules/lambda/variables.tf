variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "python3.11"
}

variable "lambda_handler" {
  description = "The function entry point in the code"
  type        = string
  default     = "hello_lambda.lambda_handler"
}

variable "s3_bucket_name" {
  description = "The S3 bucket where the Lambda code is stored"
  type        = string
}

variable "s3_key" {
  description = "The S3 key (object path name) for the Lambda zip file"
  type        = string
}

variable "iam_role_name" {
  description = "The IAM role name for Lambda execution"
  type        = string
  default     = "lambda_exec_role"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "hello-lambda-api"
}

variable "environment" {
  description = "Deployment environment (e.g., development, production)"
  type        = string
}
