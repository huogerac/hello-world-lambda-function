import json
from hello_lambda import lambda_handler


def test_should_return_200_for_valid_request(lambda_context):
    """Test if Lambda function returns status 200"""

    # GIVEN a correct request
    event = {
        "body": json.dumps({"message": "Hello, Lambda!"})
    }
    
    # WHEN we call the lambda
    response = lambda_handler(event, lambda_context)
    body = json.loads(response["body"])

    # THEN
    assert response["statusCode"] == 200
    assert "body" in response
    assert "message" in body
    assert body["message"] == "Recebido: {'message': 'Hello, Lambda!'}"


def test_should_return_400_for_invalid_request(lambda_context):
    """Test if Lambda function returns status 200"""

    # GIVEN a correct request
    event = {
        "body": '{"invalid json"}'
    }
    
    # WHEN we call the lambda
    response = lambda_handler(event, lambda_context)
    body = json.loads(response["body"])

    # THEN
    assert response["statusCode"] == 400
    assert body["error"] == "Invalid JSON format"
