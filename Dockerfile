FROM amazon/aws-lambda-python:3.11

WORKDIR /var/task

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY ./ .

CMD ["hello_lambda.lambda_handler"]
