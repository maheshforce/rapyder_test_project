import boto3
import json
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

region = 'ap-south-1'
tag_key = 'name'
tag_value = 'test'
portnum  = 80
protocol = 'tcp'


client = boto3.client('ec2', region_name=region)

#filtering based on tags
response = client.describe_instances(
    Filters=[
        {
            'Name': 'tag:' + tag_key,
            'Values': [tag_value]
        }
    ]
)

# to retrieve sg id's
for i in response['Reservations']:
    for instan in i['Instances']:
        for ni in instan['NetworkInterfaces']:
            for sg in ni['Groups']:
                security_group_id = (sg['GroupId'])

print(security_group_id)

try:
    response = client.authorize_security_group_ingress(
    GroupId=security_group_id,
    IpPermissions=[
        {
            'IpProtocol': protocol,
            'FromPort': portnum,
            'ToPort': portnum,
            'IpRanges': [
                {'CidrIp': '0.0.0.0/0'}
            ]
        }
    ]
)

    print("Inbound rule added to:", security_group_id)
except ClientError as e:
    if e.response['Error']['Code'] == 'InvalidPermission.Duplicate':
        print("Error: The rule already exists.")
    else:
        print("unexpected: {e}")


