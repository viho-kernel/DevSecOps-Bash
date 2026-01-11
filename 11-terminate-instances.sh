#!/bin/bash


terminate_instances(){

instances=$(aws ec2 describe-instances --region us-east-1 \ --query "Reservations[*].Instances[*].[InstanceId,InstanceType]" \ --output text)

ids=$(echo "$instances" | awk '$2=="t3.micro" {print $1}')

aws ec2 terminate-instances --region us-east-1 --instance-ids $ids

}

terminate_instances