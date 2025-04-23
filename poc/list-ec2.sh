#!/bin/bash

list_ec2() {
    # Prompt the user for the AWS region 
    read -p "Enter AWS Region: " region

    # Check if the region is provided
    if [ -z "$region" ]; then
        echo "Error: AWS Region is required."
        exit 1
    fi

    # Try to list EC2 instances and handle errors
    aws ec2 describe-instances --region "$region" \
        --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,BlockDeviceMappings[*].Ebs.VolumeId]" \
        --output text 2>error.log

    # Check if the command was successful
    if [ $? -ne 0 ]; then
        echo "An error occurred. Check the error.log file for details."
        exit 1
    fi
}

list_ec2
