output "lambda_function_name" {
  description = "The name of the deployed AWS Lambda function"
  value       = aws_lambda_function.hello_lambda.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the deployed AWS Lambda function"
  value       = aws_lambda_function.hello_lambda.arn
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_apigatewayv2_api.lambda_api.id
}

output "api_gateway_invoke_url" {
  description = "The invoke URL for the API Gateway endpoint"
  value       = aws_apigatewayv2_api.lambda_api.api_endpoint
}
