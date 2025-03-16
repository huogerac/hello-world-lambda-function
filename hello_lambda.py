import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):

    logger.info(f"Lambda executada: {context.function_name}")
    logger.info(f"Lambda event: {event}")
    
    if "body" not in event:
        logger.error("Ops! This is not a WEBHOOK lambda function! change it!")
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid request"})
        }

    if isinstance(event["body"], str):
        try:
            body = json.loads(event["body"])
        except json.JSONDecodeError:
            logger.error("Invalid JSON format in body")
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Invalid JSON format"})
            }
    else:
        body = event["body"]

    return {
        "statusCode": 200,
        "body": json.dumps({"message": f"Recebido: {body}"})
    }
