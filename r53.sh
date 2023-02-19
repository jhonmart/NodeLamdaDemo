aws --endpoint-url=http://localhost:4566 route53 create-hosted-zone \
  --name x4growth.com.br \
  --caller-reference 123

aws --endpoint-url=http://localhost:4566 route53 change-resource-record-sets \
  --hosted-zone-id M0CWU4F49RFSWWJ \
  --change-batch '{
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "www.x4growth.com.br",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "127.0.0.1"
          }
        ]
      }
    }
  ]
}'


{
    "HostedZone": {
        "Id": "/hostedzone/M0CWU4F49RFSWWJ",
        "Name": "x4growth.com.br.",
        "Config": {
            "PrivateZone": false
        },
        "ResourceRecordSetCount": 2
    },
    "ChangeInfo": {
        "Id": "/change/C1PA6795UKMFR9",
        "Status": "INSYNC",
        "SubmittedAt": "2017-03-15T01:36:41.958000Z"
    },
    "DelegationSet": {
        "Id": "",
        "NameServers": [
            "ns-2048.awsdns-64.com",
            "ns-2049.awsdns-65.net",
            "ns-2050.awsdns-66.org",
            "ns-2051.awsdns-67.co.uk"
        ]
    }
}

{
    "ChangeInfo": {
        "Id": "/change/C2682N5HXP0BZ4",
        "Status": "INSYNC",
        "SubmittedAt": "2010-09-10T01:36:41.958000Z"
    }
}
