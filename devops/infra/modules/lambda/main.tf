# 1
resource "aws_lambda_function" "hello_lambda" {
  function_name   = var.lambda_function_name
  role            = aws_iam_role.lambda_exec.arn
  handler         = var.lambda_handler
  runtime         = var.lambda_runtime

  s3_bucket       = var.s3_bucket_name
  s3_key          = var.s3_key

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}



# 2 - IAM for lambda execution
resource "aws_iam_role" "lambda_exec" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  name       = "lambda_policy_attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}



# 3 - get the lambda URL (webhook)
resource "aws_apigatewayv2_api" "lambda_api" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.hello_lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "POST /${var.lambda_function_name}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_deployment" "lambda_deployment" {
  api_id = aws_apigatewayv2_api.lambda_api.id

  # Re-deploy each time something changes
  depends_on = [aws_apigatewayv2_route.lambda_route]
}

resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name = "/aws/api-gateway/${var.api_gateway_name}"
}

data "aws_caller_identity" "current" {}

resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id     = aws_apigatewayv2_api.lambda_api.id
  name       = "${var.environment}"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_logs.arn
    format          = "$context.requestId"
  }
}

