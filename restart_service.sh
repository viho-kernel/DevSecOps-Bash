#!/bin/bash

if [ $# -gt 0 ]; then
    for REGION in $@; do
        aws ec2 describe-vpcs --region $1 \
        | jq -r '.Vpcs[].VpcId'
        echo "---------------------"
    done
else
    echo "Arguments provided: $@"
fi