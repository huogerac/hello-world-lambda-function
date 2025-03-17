### COMMON
variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type = string
  default = "us-east-1"
}

### STORAGE - S3 Bucket
variable "hellolambda_aws_s3_bucket" {
  type = string
  default = "hellolambda-dev-bucket"
}


### LAMBDA FUNCTION
variable "lambda_function_name" {
  type = string
  default = "hellolambda"
}

variable "lambda_runtime" {
  type = string
  default = "python3.11"
}

variable "lambda_handler" {
  type = string
  default = "hello_lambda.lambda_handler"
}

variable "s3_bucket_name" {
  type = string
  default = "hellolambda-dev-bucket"
}

variable "s3_key" {
  type = string
  default = "lambda_package.zip"
}

variable "iam_role_name" {
  type        = string
  default     = "lambda_exec_role"
}

variable "api_gateway_name" {
  type        = string
  default     = "hello-lambda-api"
}
