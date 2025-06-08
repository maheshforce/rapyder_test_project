import boto3
import csv

def list_ec2_instances(region, output_file):
    # Initialize the Boto3 EC2 client
    ec2_client = boto3.client('ec2', region_name=region)

    try:
        # Describe EC2 instances
        response = ec2_client.describe_instances()

        # Open a CSV file for writing
        with open(output_file, mode='w', newline='') as csv_file:
            fieldnames = [
                "InstanceId",
                "Platform",
                "InstanceType",
                "State",
                "PrivateIpAddress",
                "PublicIpAddress",
                "SecurityGroups",
                "CIDRs"
            ]
            writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
            writer.writeheader()

            # Iterate over reservations and instances
            for reservation in response['Reservations']:
                for instance in reservation['Instances']:
                    instance_id = instance.get('InstanceId', 'N/A')
                    platform = instance.get('PlatformDetails', 'Linux/UNIX')  # Defaults to Linux/UNIX if not specified
                    instance_type = instance.get('InstanceType', 'N/A')
                    state = instance['State']['Name']
                    private_ip = instance.get('PrivateIpAddress', 'N/A')
                    public_ip = instance.get('PublicIpAddress', 'N/A')

                    # Get associated CIDRs
                    cidrs = []
                    for interface in instance.get('NetworkInterfaces', []):
                        for group in interface.get('Groups', []):
                            cidrs.append(group.get('GroupId', 'N/A'))
                    cidrs_str = ';'.join(cidrs)

                    # Write the instance details to the CSV
                    writer.writerow({
                        "InstanceId": instance_id,
                        "Platform": platform,
                        "InstanceType": instance_type,
                        "State": state,
                        "PrivateIpAddress": private_ip,
                        "PublicIpAddress": public_ip,
                        "CIDRs": cidrs_str
                    })

        print(f"EC2 instance details have been saved to {output_file}.")

    except Exception as e:
        print(f"An error occurred: {e}")


# Replace 'us-east-1' with your desired AWS region
region = 'ap-south-1'
output_file = 'ec2_instances.csv'
list_ec2_instances(region, output_file)
