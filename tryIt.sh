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