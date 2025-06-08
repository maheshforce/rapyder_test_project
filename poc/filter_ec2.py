import boto3
import csv

def list_ec2_instances(region, column_name):
    # Initialize the Boto3 EC2 client
    ec2_client = boto3.client('ec2', region_name=region)
    input_file = "ec2_instances.csv"

    try:
        # Describe EC2 instances
        response = ec2_client.describe_instances()
        for i in response['Reservations']:
             for instance in i['Instances']:
                  print(instance["InstanceId"])
                  print(instance["PlatformDetails"])

    except Exception as e:
            print(f"An error occurred: {e}")


list_ec2_instances("ap-south-1", "InstanceId")
