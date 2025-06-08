#!/bin/bash

list_ec2() {
    # Prompt the user for the AWS region 
    read -p "Enter AWS Region: " region

    # Check if the region is provided
    if [ -z "$region" ]; then
        echo "Error: AWS Region is required."
        exit 1
    fi

    # Define the output CSV file
    output_file="output.csv"

    # Try to list EC2 instances and handle errors
    aws ec2 describe-instances --region "$region" \
        --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,BlockDeviceMappings[*].Ebs.VolumeId]" \
        --output text 2>error.log | \
        awk '
        BEGIN {
            OFS=",";
            print "InstanceId,InstanceType,State,PrivateIpAddress,PublicIpAddress,VolumeIds";
        }
        {
            # Check if the line starts with an instance ID (starts with "i-")
            if ($1 ~ /^i-/) {
                # Print the previous instance details if there are any
                if (instance_id != "") {
                    print instance_id, instance_type, state, private_ip, public_ip, volume_ids;
                }
                # Capture new instance details
                instance_id = $1;
                instance_type = $2;
                state = $3;
                private_ip = $4;
                public_ip = $5;
                volume_ids = ""; # Reset volume IDs
            } else {
                # Append volume IDs to the current instance
                if (volume_ids == "") {
                    volume_ids = $1;
                } else {
                    volume_ids = volume_ids ";" $1;
                }
            }
        }
        END {
            # Print the last instance details
            if (instance_id != "") {
                print instance_id, instance_type, state, private_ip, public_ip, volume_ids;
            }
        }' > "$output_file"

    # Check if the command was successful
    if [ $? -ne 0 ]; then
        echo "An error occurred. Check the error.log file for details."
        exit 1
    fi

    echo "EC2 instance details have been exported to $output_file."
}

list_ec2
