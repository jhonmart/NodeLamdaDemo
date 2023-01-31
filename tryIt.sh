aws --endpoint-url=http://localhost:4566 lambda create-function \
  --function-name lambda-dev-hello \
  --runtime nodejs12.x \
  --handler handler.hello \
  --zip-file fileb://.serverless/lambda.zip \
  --role demo

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
