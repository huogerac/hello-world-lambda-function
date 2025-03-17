terraform {                                      #this is we tell terraform we config AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# TODO: Falta colocar configuração para manter o STATE no S3

### STORAGE
module "s3" {
  source = "../modules/s3"

  environment  = var.environment
  region = var.region
  hellolambda_aws_s3_bucket = var.hellolambda_aws_s3_bucket
}

output "AWS_ACCESS_KEY_ID" {
  value = module.s3.access_key_id
}

output "AWS_SECRET_ACCESS_KEY" {
  sensitive = true
  value = module.s3.secret_access_key
}

output "BUCKET_LAMBDA_CODE" {
  value = module.s3.s3_bucket_name
}


### LAMBDA
module "lambda" {
  source = "../modules/lambda"

  environment  = var.environment

  lambda_function_name = var.lambda_function_name
  lambda_runtime = var.lambda_runtime
  lambda_handler = var.lambda_handler
  s3_bucket_name = module.s3.s3_bucket_name
  s3_key = var.s3_key
  iam_role_name = var.iam_role_name
  api_gateway_name = var.api_gateway_name
}

output "LAMBDA_FUNCTION_NAME" {
  value = module.lambda.lambda_function_name
}

output "LAMBDA_FUNCTION_ARN" {
  value = module.lambda.lambda_function_arn
}

output "LAMBDA_API_GATEWAY_ID" {
  value = module.lambda.api_gateway_id
}

output "LAMBDA_API_GATEWAY_INVOKE_URL" {
  value = module.lambda.api_gateway_invoke_url
}
