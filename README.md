# 🌐 Hello World com AWS Lambda Function

Tudo que precisamos para começar certo com Lambda Function


## Rodando local com docker

docker build -t hello-lambda .
docker run -p 9000:8080 hello-lambda

curl -X POST "http://localhost:9000/2015-03-31/functions/function/invocations" \
     -H "Content-Type: application/json" \
     -d '{"message": "Test message", "body": "{\"ping\": true}"}'

curl -X POST "http://localhost:9000/2015-03-31/functions/function/invocations" \
     -H "Content-Type: application/json" \
     -d '{"body": "{\"message\": \"ping\"}"}'


## Rodando com docker compose

docker compose up --build -d
docker compose logs -f hello_lambda
docker compose down
