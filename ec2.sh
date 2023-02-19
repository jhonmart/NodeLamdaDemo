
aws --endpoint-url=http://localhost:4566 ec2 create-security-group \
  --group-name my-security-group \
  --description "My security group"

{
    "GroupId": "sg-a1e52509e61a3db42",
    "Tags": []
}

aws --endpoint-url=http://localhost:4566 ec2 authorize-security-group-ingress \
  --group-name my-security-group \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-6ac212ecb0ccdf9e4",
            "GroupId": "sg-a1e52509e61a3db42",
            "GroupOwnerId": "000000000000",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIpv4": "0.0.0.0/0",
            "Description": ""
        }
    ]
}

aws --endpoint-url=http://localhost:4566 ec2 create-key-pair \
  --key-name my-key-pair \
  --query 'KeyMaterial' \
  --output text > my-key-pair.pem

aws --endpoint-url=http://localhost:4566 ec2 create-vpc \
  --cidr-block 0.0.0.0/24
{
    "Vpc": {
        "CidrBlock": "0.0.0.0/24",
        "DhcpOptionsId": "dopt-1a2b3c4d2",
        "State": "pending",
        "VpcId": "vpc-c3323b3a",
        "OwnerId": "000000000000",
        "InstanceTenancy": "default",
        "Ipv6CidrBlockAssociationSet": [],
        "CidrBlockAssociationSet": [
            {
                "AssociationId": "vpc-cidr-assoc-b6df0900",
                "CidrBlock": "0.0.0.0/24",
                "CidrBlockState": {
                    "State": "associated"
                }
            }
        ],
        "Tags": []
    }
}

aws --endpoint-url=http://localhost:4566 ec2 create-subnet \
  --vpc-id vpc-c3323b3a \
  --cidr-block 0.0.0.0/24

{
    "Subnet": {
        "AvailabilityZone": "us-east-1d",
        "AvailabilityZoneId": "use1-az4",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "0.0.0.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "pending",
        "SubnetId": "subnet-95245ef7",
        "VpcId": "vpc-c3323b3a",
        "OwnerId": "000000000000",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "Tags": [],
        "SubnetArn": "arn:aws:ec2:us-east-1:000000000000:subnet/subnet-95245ef7",
        "Ipv6Native": false
    }
}

aws --endpoint-url=http://localhost:4566 ec2 run-instances \
--image-id ami-0c55b159cbfafe1f0 \
--instance-type t4.medium \
--key-name my-key-pair \
--security-group-ids sg-a1e52509e61a3db42 \
--subnet-id subnet-2fd9bbd4 \
--count 1

{
    "Groups": [
        {
            "GroupName": "default",
            "GroupId": "sg-245f6a01"
        }
    ],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0c55b159cbfafe1f0",
            "InstanceId": "i-ac50512b3a7728bbe",
            "InstanceType": "t4.medium",
            "KernelId": "None",
            "KeyName": "my-key-pair",
            "LaunchTime": "2023-02-05T00:59:32Z",
            "Monitoring": {
                "State": "enabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1c",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-10-0-1-4.ec2.internal",
            "PrivateIpAddress": "10.0.1.4",
            "PublicDnsName": "None",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-2fd9bbd4",
            "VpcId": "vpc-a12c6b91",
            "Architecture": "x86_64",
            "ClientToken": "",
            "EbsOptimized": false,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2015-01-01T00:00:00Z",
                        "AttachmentId": "eni-attach-c6134e8a",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attached"
                    },
                    "Description": "Primary network interface",
                    "Groups": [
                        {
                            "GroupName": "my-security-group",
                            "GroupId": "sg-a1e52509e61a3db42"
                        }
                    ],
                    "MacAddress": "1b:2b:3c:4d:5e:6f",
                    "NetworkInterfaceId": "eni-abfc7355",
                    "OwnerId": "000000000000",
                    "PrivateIpAddress": "10.0.1.4",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "10.0.1.4"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-2fd9bbd4",
                    "VpcId": "vpc-a12c6b91"
                }
            ],
            "SecurityGroups": [
                {
                    "GroupName": "my-security-group",
                    "GroupId": "sg-a1e52509e61a3db42"
                }
            ],
            "SourceDestCheck": true,
            "Tags": [],
            "VirtualizationType": "paravirtual"
        }
    ],
    "OwnerId": "000000000000",
    "ReservationId": "r-8dfe0716"
}

chmod 400 my-key-pair.pem

aws --endpoint-url=http://localhost:4566 ec2 allocate-address \
  --domain vpc

{
    "PublicIp": "127.66.34.38",
    "AllocationId": "eipalloc-c81a56dd",
    "Domain": "vpc"
}

aws --endpoint-url=http://localhost:4566 ec2 associate-address \
  --instance-id i-ac50512b3a7728bbe \
  --public-ip 127.66.34.38

{
    "AssociationId": "eipassoc-7e19116d"
}

aws --endpoint-url=http://localhost:4566 ec2 describe-instances \
  --instance-ids i-ac50512b3a7728bbe \
  --query 'Reservations[0].Instances[0].PublicIpAddress'

aws --endpoint-url=http://localhost:4566 ec2 modify-subnet-attribute \
  --subnet-id subnet-95245ef7 \
  --map-public-ip-on-launch

"127.66.34.38"

aws --endpoint-url=http://localhost:4566 ec2 stop-instances \
  --instance-ids i-ac50512b3a7728bbe
{
    "StoppingInstances": [
        {
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "InstanceId": "i-ac50512b3a7728bbe",
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
aws --endpoint-url=http://localhost:4566 ec2 modify-instance-attribute \
  --instance-id i-ac50512b3a7728bbe \
  --subnet-id subnet-95245ef7

aws --endpoint-url=http://localhost:4566 ec2 start-instances \
  --instance-ids i-ac50512b3a7728bbe

ssh -i my-key-pair.pem ec2-user@ec2-54-214-215-92.compute-1.amazonaws.com

aws  --endpoint-url=http://localhost:4566 ec2 authorize-security-group-ingress --group-id default --protocol tcp --port 8080
aws  --endpoint-url=http://localhost:4566 ec2 describe-security-groups --group-names default
aws  --endpoint-url=http://localhost:4566 ec2 run-instances --image-id ami-df5de72bdb3b --user-data '#!/bin/bash
    whoami | tee /myname && echo localstack; echo "not printed">/dev/null;'
{
    "Groups": [
        {
            "GroupName": "default",
            "GroupId": "sg-245f6a01"
        }
    ],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-df5de72bdb3b",
            "InstanceId": "i-bbbeac5bb82fabf1f",
            "InstanceType": "m1.small",
            "KernelId": "None",
            "LaunchTime": "2023-02-05T01:44:15Z",
            "Monitoring": {
                "State": "enabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1a",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-10-68-109-16.ec2.internal",
            "PrivateIpAddress": "10.68.109.16",
            "PublicDnsName": "ec2-54-214-215-92.compute-1.amazonaws.com",
            "PublicIpAddress": "54.214.215.92",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-31175f88",
            "VpcId": "vpc-38e595df",
            "Architecture": "x86_64",
            "ClientToken": "",
            "EbsOptimized": false,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Association": {
                        "IpOwnerId": "000000000000",
                        "PublicIp": "54.214.215.92"
                    },
                    "Attachment": {
                        "AttachTime": "2015-01-01T00:00:00Z",
                        "AttachmentId": "eni-attach-0114ea40",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attached"
                    },
                    "Description": "Primary network interface",
                    "Groups": [
                        {
                            "GroupName": "default",
                            "GroupId": "sg-88115d56713afb622"
                        }
                    ],
                    "MacAddress": "1b:2b:3c:4d:5e:6f",
                    "NetworkInterfaceId": "eni-07aa5551",
                    "OwnerId": "000000000000",
                    "PrivateIpAddress": "10.68.109.16",
                    "PrivateIpAddresses": [
                        {
                            "Association": {
                                "IpOwnerId": "000000000000",
                                "PublicIp": "54.214.215.92"
                            },
                            "Primary": true,
                            "PrivateIpAddress": "10.68.109.16"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-31175f88",
                    "VpcId": "vpc-38e595df"
                }
            ],
            "SecurityGroups": [],
            "SourceDestCheck": true,
            "Tags": [],
            "VirtualizationType": "paravirtual"
        }
    ],
    "OwnerId": "000000000000",
    "ReservationId": "r-a6fcf0ae"
}
