aws --endpoint-url=http://localhost:4566 lambda create-function \
  --function-name lambda-node-request \
  --runtime nodejs12.x \
  --handler handler.request \
  --zip-file fileb://.serverless/lambda.zip \
  --role demo

serverless deploy
aws --endpoint-url=http://localhost:4566 lambda update-function-code \
  --function-name lambda-node-request \
  --zip-file fileb://.serverless/lambda.zip

aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name lambda-node-request \
  --payload '{"hostname":"192.168.0.169","port":5000,"path":"/api/list-sessions","method":"GET"}' \
  output.json

aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name lambda-dev-hello \
  --payload '{"key": "value"}' \
  output.json

aws --endpoint-url=http://localhost:4566 apigateway create-rest-api \
  --name dev-hello

aws --endpoint-url=http://localhost:4566 apigateway get-resources \
  --rest-api-id fx73ji8x0e

aws --endpoint-url=http://localhost:4566 apigateway create-resource \
  --rest-api-id fx73ji8x0e \
  --parent-id p6khoyblxx \
  --path-part demo

aws --endpoint-url=http://localhost:4566 apigateway put-method \
  --rest-api-id fx73ji8x0e \
  --resource-id q2grh13nyy \
  --http-method POST \
  --authorization-type NONE

aws --endpoint-url=http://localhost:4566 apigateway put-integration \
  --rest-api-id fx73ji8x0e \
  --resource-id q2grh13nyy \
  --http-method POST \
  --type AWS \
  --integration-http-method POST \
  --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:*:function:lambda-dev-hello/invocations

aws --endpoint-url=http://localhost:4566 apigateway create-deployment \
  --rest-api-id fx73ji8x0e \
  --stage-name prod

aws --endpoint-url=http://localhost:4566 apigateway get-stage \
  --rest-api-id fx73ji8x0e \
  --stage-name prod

curl -X POST http://localhost:4566/restapis/fx73ji8x0e/prod/demo

{
    "FunctionName": "lambda-dev-hello",
    "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:lambda-dev-hello",
    "Runtime": "nodejs12.x",
    "Role": "demo",
    "Handler": "handler.hello",
    "CodeSize": 583,
    "Description": "",
    "Timeout": 3,
    "LastModified": "2023-01-31T00:12:35.573+0000",
    "CodeSha256": "fSbdgOhlSC2nCBHaWjUAL8ofs/od5AN2R4pPWz5lnOA=",
    "Version": "$LATEST",
    "VpcConfig": {},
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "172503d7-be24-49a6-8d62-55d830748c64",
    "State": "Active",
    "LastUpdateStatus": "Successful",
    "PackageType": "Zip",
    "Architectures": [
        "x86_64"
    ]
}

{
  "StatusCode": 200,
  "LogResult": "",
  "ExecutedVersion": "$LATEST"
}

{
    "id": "fx73ji8x0e",
    "name": "dev-hello",
    "createdDate": 1675164010.0,
    "apiKeySource": "HEADER",
    "endpointConfiguration": {
        "types": [
            "EDGE"
        ]
    },
    "disableExecuteApiEndpoint": false
}

{
    "items": [
        {
            "id": "p6khoyblxx",
            "path": "/"
        }
    ]
}

{
    "id": "q2grh13nyy",
    "parentId": "p6khoyblxx",
    "pathPart": "demo",
    "path": "/demo"
}

{
    "httpMethod": "POST",
    "authorizationType": "NONE",
    "apiKeyRequired": false,
    "methodResponses": {}
}

{
    "type": "AWS",
    "httpMethod": "POST",
    "uri": "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:lambda-dev-hello/invocations",
    "requestParameters": {},
    "cacheNamespace": "q2grh13nyy",
    "cacheKeyParameters": []
}

{
    "id": "fg2qxuuv71",
    "createdDate": 1675166142.0
}


TIMESTAMP=$(($(date +%s -d "today 12:05") * 1000))

aws --endpoint-url=http://localhost:4566 events put-rule \
  --name "MyScheduledRule" \
  --schedule-expression "cron(30 16 20 2 ? 2023)"

aws --endpoint-url=http://localhost:4566 events put-targets \
  --rule "MyScheduledRule" \
  --targets "{\"Id\":\"MyLambdaTarget\",\"Arn\":\"arn:aws:lambda:us-east-1:000000000000:function:lambda-node-request\",\"Input\":\"{\\\"hostname\\\":\\\"192.168.0.169\\\",\\\"port\\\":5000,\\\"path\\\":\\\"/upload/5\\\",\\\"method\\\":\\\"GET\\\"}\"}"

aws --endpoint-url=http://localhost:4566 events put-scheduled-rule \
  --schedule-expression "cron(42 14 * * ? *)" \
  --name "meu-evento-agendado" \
  --description "Evento agendado para executar minha função Lambda" \
  --state ENABLED \
  --cli-input-json file://caminho/para/o/seu/arquivo.json


aws --endpoint-url=http://localhost:4566  events list-rules \
  --name "meu-evento-agendado" \
  --schedule-expression "cron(54 0 21 2 ? 2023)" \
  --state ENABLED \
  --description "Evento agendado para executar minha função Lambda" \
  --output json

aws --endpoint-url=http://localhost:4566  events put-targets \
  --rule "meu-evento-agendado" \
  --targets "{\"Id\":\"MyLambdaTarget\",\"Arn\":\"arn:aws:lambda:us-east-1:000000000000:function:lambda-node-request\",\"Input\":\"{\\\"hostname\\\":\\\"192.168.0.169\\\",\\\"port\\\":5000,\\\"path\\\":\\\"/code/39\\\",\\\"method\\\":\\\"GET\\\"}\"}"

aws --endpoint-url=http://localhost:4566 s3api create-bucket \
  --bucket x4wappdata

aws --endpoint-url=http://localhost:4566 s3api put-object \
  --bucket x4wappdata --acl public-read --key msg-22-112.csv --body addresses.csv

aws --endpoint-url=http://localhost:4566 s3 ls s3://x4wappdata/ \
  --recursive \
  --human-readable \
  --summarize
