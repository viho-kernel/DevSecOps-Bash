#!/bin/bash

terminate_instances() {
  ids=$(aws ec2 describe-instances \
    --region us-east-1 \
    --query "Reservations[].Instances[?InstanceType=='t3.micro'].InstanceId" \
    --output text)

  if [ -n "$ids" ]; then
    echo "Terminating instances: $ids"
    aws ec2 terminate-instances --region us-east-1 --instance-ids $ids
  else
    echo "No t3.micro instances found."
  fi
}
